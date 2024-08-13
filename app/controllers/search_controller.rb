class SearchController < ApplicationController
  def index
    # Uncomment this line to enable Pundit
    # authorize :search, :index?
    # @companies = policy_scope(Company).where("company_name ILIKE ?", "%#{@query}%")
    # @complaints = policy_scope(Complaint).where("title ILIKE ?", "%#{@query}%")
    @query = params[:query]
    @companies = Company.where("company_name ILIKE ?", "%#{@query}%")
    @complaints = Complaint.where("title ILIKE ?", "%#{@query}%")
  end
end
