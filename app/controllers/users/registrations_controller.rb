# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :check_registration_type, only: [:new, :create]
  before_action :set_resource, only: [:new, :create]

  def create
    super do |resource|
      if resource.persisted?
        resource.update(is_company: session[:registration_type])
        role = params[:registration_type]&.[](:role) || session[:role]
        if session[:registration_type] && session[:company_id].present?
          company = Company.find_by(id: session[:company_id])
          if company && role.present?
            CompaniesUser.create!(user: resource, company: company, role: role)
          end
        else
          session[:role] = role if role.present? # Armazena o role na sessão
        end
        session.delete(:registration_type)
        session.delete(:company_id)
      end
    end
  end

  def registration_type
    if request.xhr? && params[:query].present?
      query = params[:query]
      companies = Company.where("company_name ILIKE ?", "%#{query}%").limit(10)
      render json: companies.map { |company| { id: company.id, name: company.company_name } }
    elsif request.post?
      # Verifica se o company_id está fora do hash registration_type e o move para dentro
      if params[:company_id].present?
        params[:registration_type][:company_id] = params[:company_id]
      end
  
      # Salva o tipo da sessão e o ID da empresa
      session[:registration_type] = params[:registration_type][:is_company] == 'true'
      if params[:registration_type][:is_company] == 'true'
        session[:company_id] = params[:registration_type][:company_id] 
      end
      
      session[:role] = params[:registration_type][:role] if params[:registration_type][:is_company] == 'true'
      redirect_to new_user_registration_path
    else
      render :registration_type
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :is_company, :username])
  end

  def after_sign_up_path_for(resource)
    if resource.is_company?
      if resource.companies.empty?
        new_company_path
      else
        root_path
      end
    else
      user_path(resource)
    end
  end

  def check_registration_type
    if session[:registration_type].nil?
      redirect_to choose_registration_type_path
    end
  end

  def set_resource
    @is_company = params.dig(:user, :is_company) == 'true' || session[:registration_type] == true
    build_resource({})
    resource.is_company = @is_company
  end
end
