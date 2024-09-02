class SearchController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @query = params[:query]
    @category = params[:company_category]

    @companies = policy_scope(Company)
    if @query.present?
      @companies = @companies.where("company_name ILIKE ?", "%#{@query}%")
    end

    if @category.present? && Company::COMPANY_CATEGORY.include?(@category)
      @companies = @companies.where(company_category: @category)
    end

    @complaints = policy_scope(Complaint).where("title ILIKE ?", "%#{@query}%")
  end
end
