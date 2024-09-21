class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update]
  before_action :check_company_user, only: [:new, :create, :edit, :update] 
  skip_before_action :authenticate_user!, only: [:index, :show, :top_scored_companies, :low_scored_companies]

  COMPANY_CATEGORY = Company::COMPANY_CATEGORY
  
  def index
    authorize Company
    @companies = Company.all.order(created_at: :desc)
    @categories = Company.select(:company_category).distinct.pluck(:company_category)
  end
  def new
    authorize Company
    @company = Company.new
  end

  def user_companies
    @companies = current_user.companies.where(id: params[:companies_ids])
  end
  
  def create
    authorize Company
    @company = Company.new(company_params)
  
    if company_params[:company_social_media].values.all?(&:blank?)
      flash[:alert] = "Por favor, preencha pelo menos um campo de rede social."
      render :new and return
    end
  
    if @company.save
      role = session[:role] || params[:role]
  
      if current_user.admin?
        redirect_to company_path(@company), notice: 'Empresa criada com sucesso pelo administrador.' and return
      else
        if role.present?
          CompaniesUser.create!(user: current_user, company: @company, role: role)
          session.delete(:role)
          redirect_to company_path(@company), notice: 'Empresa criada com sucesso.' and return
        else
          @company.destroy
          flash[:alert] = "Cargo não selecionado."
          render :new and return
        end
      end
    else
      flash[:alert] = 'Falha ao salvar a Empresa: ' + @company.errors.full_messages.to_sentence
      render :new and return
    end
  end
  

  def show
    authorize @company
    @company = Company.find(params[:id])
    @complaints = @company.complaints.order(created_at: :desc)
    @answered_complaints = @company.complaints.joins(:responses).distinct
    @unanswered_complaints = @company.complaints.left_joins(:responses).where(responses: { id: nil })
    @new_complaint = Complaint.new
  end

  def edit
    authorize @company
  end

  def update
    authorize @company

    social_media_params = {
      facebook: params[:company][:company_social_media_facebook],
      twitter: params[:company][:company_social_media_twitter],
      linkedin: params[:company][:company_social_media_linkedin],
      instagram: params[:company][:company_social_media_instagram],
      youtube: params[:company][:company_social_media_youtube],
      tiktok: params[:company][:company_social_media_tiktok]
    }

    if @company.update(company_params.merge(company_social_media: social_media_params))
      redirect_to company_path(@company), notice: 'Empresa atualizada com sucesso.'
    else
      Rails.logger.debug "Erro ao atualizar a empresa: #{@company.errors.full_messages.join(', ')}"
      flash[:alert] = 'Falha ao atualizar a Empresa: ' + @company.errors.full_messages.to_sentence
      render :edit
    end
  end


  def destroy
  end

  def top_scored_companies
    authorize :company, :top_scored_companies?
    @top_ranked_companies = Company
                              .joins(:complaints)
                              .left_joins(:complaints => :responses)
                              .group('companies.id')
                              .select('companies.*, COUNT(complaints.id) AS complaints_count,
             SUM(CASE WHEN responses.id IS NOT NULL THEN 1 ELSE 0 END) AS answered_complaints_count')
                              .having('COUNT(complaints.id) > 0 AND SUM(CASE WHEN responses.id IS NOT NULL THEN 1 ELSE 0 END) > 0')
                              .order(Arel.sql('SUM(CASE WHEN responses.id IS NOT NULL THEN 1 ELSE 0 END) / COUNT(complaints.id) DESC'))
  end

  def low_scored_companies
    authorize :company, :low_scored_companies?
    @low_ranked_companies = Company
                              .joins(:complaints)
                              .left_joins(:complaints => :responses)
                              .group('companies.id')
                              .select('companies.*,
             COUNT(complaints.id) AS total_complaints,
             SUM(CASE WHEN responses.id IS NULL THEN 1 ELSE 0 END) AS unanswered_complaints,
             AVG(CASE WHEN responses.id IS NULL THEN 1 ELSE 0 END) AS unanswered_complaints_ratio')
                              .having('COUNT(complaints.id) > 0 AND SUM(CASE WHEN responses.id IS NULL THEN 1 ELSE 0 END) > 0')
                              .order('unanswered_complaints_ratio DESC')
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end
  
  def company_params
    params.require(:company).permit(
      :company_name, 
      :company_register_number, 
      :company_address, 
      :company_city,
      :company_prefecture, 
      :company_zip_code, 
      :company_country, 
      :company_phone_number,
      :company_website, 
      :company_description, 
      :company_category,
      :company_logo,
      :company_banner,
      :company_banner_url, 
      :company_logo_url,
      :company_contact_name, 
      :company_contact_email, 
      company_social_media: [:facebook, :twitter, :linkedin, :instagram, :youtube, :tiktok]
    )
  end
  
  
  def check_company_user
    unless current_user.company? || current_user.admin?
      redirect_to root_path, alert: "Você não tem permissão para criar uma empresa."
    end
  end
end
