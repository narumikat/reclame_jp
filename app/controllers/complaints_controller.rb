class ComplaintsController < ApplicationController
  before_action :set_company, only: [:index, :create, :show], if: -> { params[:company_id].present? }
  before_action :set_complaint, only: [:show]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    authorize Complaint
    
    if @company.present?
      @complaints = @company.complaints.order(created_at: :desc)
    else
      @complaints = Complaint.where(user_id: current_user.id).order(created_at: :desc)
    end
  
    if params[:respondidas].present?
      if params[:respondidas] == "true"
        @complaints = @complaints.joins(:responses).distinct
      elsif params[:respondidas] == "false"
        @complaints = @complaints.left_joins(:responses).where(responses: { id: nil })
      end
    end
  end

  def user_complaints
    @user = User.find(params[:user_id])
    authorize @user
  
    if params[:companies_ids].present?
      @complaints = Complaint.where(company_id: params[:companies_ids]).order(created_at: :desc)
    else
      @complaints = @user.complaints.order(created_at: :desc)
    end

    if params[:respondidas].present?
      if params[:respondidas] == "true"
        @complaints = @complaints.joins(:responses).distinct
      elsif params[:respondidas] == "false"
        @complaints = @complaints.left_joins(:responses).where(responses: { id: nil })
      end
    end
  end
  
  def show
    @complaint = Complaint.includes(:company, responses: :responses).find(params[:id])
    @company = @complaint.company
    authorize @complaint
    @response = Response.new
    @responses = @complaint.responses.where(parent_id: nil).order(created_at: :desc)
  end
  
  def new
    authorize Complaint
    @complaint = Complaint.new
    @complaint.build_company
  end

  def create
    authorize Complaint
    Rails.logger.debug "Received params: #{params.inspect}"
    @complaint = Complaint.new(complaint_params.merge(user: current_user))
  
    if @complaint.save
      @company = @complaint.company
      # Descomentar esta linha abaixo para enviar email.
      # SendgridMailer.send_email(current_user).deliver_now
      redirect_to @complaint, notice: 'Complaint was successfully created.'
    else
      handle_existing_or_new_company
    end
  end
  
  
  private

  def handle_existing_or_new_company
    company_social_url = complaint_params.dig(:company_attributes, :company_social_media)
    
    if company_social_url.present?
      existing_company = find_company_by_social_media(company_social_url)
      if existing_company
        link_complaint_to_existing_company(existing_company)
      else
        create_company
      end
    else
      render_complaint_errors
    end
  end

  def link_complaint_to_existing_company(existing_company)
    @complaint.update(company_id: existing_company.id)
    redirect_to company_path(existing_company), notice: 'Complaint was successfully created and linked to an existing company.'
  end
  
  def create_company
    @company = Company.create(
      company_name: complaint_params[:new_company_name],
      company_social_media: complaint_params[:company_social_media],
      company_city: complaint_params.dig(:company_attributes, :company_city),
      company_state: complaint_params.dig(:company_attributes, :company_state),
      company_category: [complaint_params.dig(:company_attributes, :company_category)]
      )
      if @company.save
        @complaint.update(company_id: @company.id)
        redirect_to companies_path, notice: 'Complaint and new company were successfully created.'
      else
        flash[:alert] = 'Failed to create company: ' + @company.errors.full_messages.to_sentence
        render :new
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
      :company_id, :title, :review, :comment, :complaint_category,
      company_attributes: [
        :company_name, :company_category, :company_city, :company_state,
        company_social_media: [:facebook, :twitter, :linkedin, :instagram, :youtube, :tiktok]
      ]
    )
  end
  
  def set_company
    @company = Company.find(params[:company_id]) if params[:company_id].present?
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