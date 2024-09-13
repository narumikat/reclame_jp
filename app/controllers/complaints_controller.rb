class ComplaintsController < ApplicationController
  before_action :set_company, only: [:index, :create, :show, :destroy], if: -> { params[:company_id].present? }
  before_action :set_complaint, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    authorize Complaint
    
    # if @company.present?
    #   @complaints = @company.complaints.order(created_at: :desc)
    # else
    #   @complaints = Complaint.where(user_id: current_user.id).order(created_at: :desc)
    # end
  
    # if params[:respondidas].present?
    #   if params[:respondidas] == "true"
    #     @complaints = @complaints.joins(:responses).distinct
    #   elsif params[:respondidas] == "false"
    #     @complaints = @complaints.left_joins(:responses).where(responses: { id: nil })
    #   end
    # end
    @complaints = policy_scope(Complaint.all).order(created_at: :desc)
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
      UserMailer.email_to_company(@company.company_contact_email, @complaint).deliver_now
      redirect_to @complaint, notice: 'Reclamação criada com sucesso. Um email de confirmação foi enviado para a empresa.'
    else
      handle_existing_or_new_company
    end
  end
  
  def edit
    
  end

  def update
    
  end
  
  def destroy
    @complaint = Complaint.find(params[:id])
    authorize @complaint
    if @complaint.destroy
      flash[:success] = "Reclamação excluída com sucesso."
    else
      flash[:error] = "Erro ao excluir a reclamação."
    end
    redirect_to company_complaints_path(@complaint.company)
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
    redirect_to company_path(existing_company), notice: 'Reclamaçaõ e Empresa existente foram vinculadas com sucesso.'
  end
  
  def create_company
    @company = Company.create(
      company_name: complaint_params[:new_company_name],
      company_social_media: complaint_params[:company_social_media],
      company_city: complaint_params.dig(:company_attributes, :company_city),
      company_prefecture: complaint_params.dig(:company_attributes, :company_prefecture),
      company_category: [complaint_params.dig(:company_attributes, :company_category)]
      )
      if @company.save
        @complaint.update(company_id: @company.id)
        redirect_to companies_path, notice: 'Reclamação e Empresa criadas com sucesso.'
      else
        flash[:alert] = 'Falha ao criar a Empresa: ' + @company.errors.full_messages.to_sentence
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
        :company_name, :company_category, :company_city, :company_prefecture,
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