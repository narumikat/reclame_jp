# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :check_registration_type, only: [:new, :create]
  before_action :set_resource, only: [:new]


  def create
    super do |resource|
      if resource.persisted?
        resource.update(is_company: session[:registration_type])
        if session[:registration_type] && session[:company_id].present?
          company = Company.find_by(id: session[:company_id])
          role = params[:registration_type][:role]
          if company && role.present?
            CompaniesUser.create!(user: resource, company: company, role: role)
            puts "User associated with company: #{company.company_name}"
          else
            puts "User already associated with company: #{company.company_name}"
          end
        else
          flash[:alert] = "Company not found"
        end
        session.delete(:registration_type)
        session.delete(:company_id)
      end
    end
  end

  def registration_type
    if request.post?
      # registra e salva a o tipo da sessasão
      session[:registration_type] = params[:registration_type][:is_company] == 'true'
      # registra e salva o id da empresa, e envia para o create
      session[:company_id] = params[:registration_type][:company_id] if params[:registration_type][:is_company] == 'true'
      redirect_to new_user_registration_path
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :is_company])
  end

  def after_sign_up_path_for(resource)
    if resource.is_company?
      if resource.companies.empty?
        new_company_path
      else
        companies_path
      end
    else
      new_user_path
    end
  end

  def check_registration_type
    if session[:registration_type].nil?
      redirect_to choose_registration_type_path
    end
  end

  # Verifica se o usuário escolheu se registrar como empresa ou pessoa física
  def set_resource
    @is_company = session[:registration_type] == true
    build_resource({})
    resource.is_company = @is_company
  end
end
