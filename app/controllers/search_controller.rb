class SearchController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @query = params[:query]
    @companies = policy_scope(Company).where("company_name ILIKE ?", "%#{@query}%")
    @complaints = policy_scope(Complaint).where("title ILIKE ?", "%#{@query}%")
  end
end
