class ComplaintsController < ApplicationController
  before_action :set_company, only: [:create, :show], if: -> { params[:company_id].present? }
  before_action :set_complaint, only: [:show]
  def index
    @complaints = current_user.complaints
  end

  def show
    @complaint = Complaint.includes(:responses).find(params[:id])
    @response = Response.new
  end

  def new_complaint
    @complaint = Complaint.new
  end

  def new
    @complaint = Complaint.new
  end
  
  def create
    @complaint = Complaint.new(complaint_params)
    @complaint.user = current_user

    # Verificar se uma nova empresa está sendo criada
    if @complaint.company_id.blank? && complaint_params[:new_company_name].present?
      # Salvar os detalhes da nova empresa
      @complaint.company_id = nil
      @complaint.new_company_name = complaint_params[:new_company_name]
      @complaint.company_social_media = complaint_params[:company_social_media]
    end

    if @complaint.save
      if params[:company_id].present?
        redirect_to @complaint, notice: 'Complaint was successfully created.'
      else
        redirect_to companies_path, notice: 'Complaint was successfully created'
      end
    else
      flash[:alert] = 'Failed to save the complaint: ' + @complaint.errors.full_messages.to_sentence
      render :new
    end
  end
  

  private

  def complaint_params
    params.require(:complaint).permit(
      :company_id, 
      :user_id,
      :title,
      :review,
      :comment, 
      :new_company_name, 
      company_social_media: [
        :facebook, 
        :twitter, 
        :linkedin, 
        :instagram, 
        :youtube, 
        :tiktok
      ]
    )
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_complaint
    if params[:company_id].present?
      @company = Company.find(params[:company_id])
      @complaint = @company.complaints.find(params[:id])
    else
      @complaint = Complaint.find(params[:id])
    end
  end
end