class ComplaintsController < ApplicationController
  before_action :set_company
  before_action :set_complaint, only: [:show]
  def index
    @complaints = Complaint.all
  end

  def show
    @complaint = Complaint.includes(:responses).find(params[:id])
  end

  def new
    @complaint = Complaint.new
  end

  def create
    @complaint = Complaint.new(complaint_params)

    if @complaint.save
      redirect_to @complaint
    else
      render 'new'
    end
  end

  private
  def complaint_params
    params.require(:complaint).permit(:title, :content)
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_complaint
    @complaint = @company.complaints.find(params[:id])
  end
end