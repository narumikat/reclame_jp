class ComplaintsController < ApplicationController
  before_action :set_company, only: [:create, :show], if: -> { params[:company_id].present? }
  before_action :set_complaint, only: [:show]
  def index
    @complaints = current_user.complaints.order(created_at: :desc)
  end

  def show
    @complaint = Complaint.includes(:responses).find(params[:id])
    @response = Response.new
    @responses = @complaint.responses.order(created_at: :desc)
  end

  def new
    @complaint = Complaint.new
  end
  
  def create
    @complaint = Complaint.new(complaint_params)
    @complaint.user = current_user
  
    if @complaint.save
      handle_complaint_create
    else
      flash[:alert] = 'Failed to save the complaint: ' + @complaint.errors.full_messages.to_sentence
      render :new
    end
  end
  
  private

  def handle_complaint_create
    if complaint_params[:company_id].present?
      redirect_to @complaint, notice: 'Complaint was successfully created.'
    else
      existing_company = find_company_by_social_media(complaint_params[:company_social_media])
      
      if existing_company
        @complaint.update(company_id: existing_company.id)
        redirect_to company_path(existing_company), notice: 'Complaint was successfully created and linked to an existing company.'
      else
        @company = Company.create(
          company_name: complaint_params[:new_company_name],
          company_social_media: complaint_params[:company_social_media],
          company_city: 'default',
          company_state: 'default'
        )
        @complaint.update(company_id: @company.id)
        redirect_to companies_path, notice: 'Complaint and new company were successfully created.'
      end
    end
  end
  
  def find_company_by_social_media(social_media)
    social_media.each do |platform, url|
      next if url.blank?
      company = Company.where("company_social_media @> ?", { platform => url }.to_json).first
      return company if company
    end
    nil
  end

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