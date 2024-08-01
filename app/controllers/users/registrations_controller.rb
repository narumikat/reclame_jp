# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :registration_type, only: [:new]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   supeß
  # end

  # POST /resource
  # def create
  #   super
  # end
  
  def create
    super do |resource|
      if resource.persisted?
        resource.update(company: session[:registration_type])
        session.delete(:registration_type)
      end
    end
  end
  
  def registration_type
    if request.post?
      session[:registration_type] = params[:registration_type][:company] == "true"
      redirect_to new_user_registration_path
    end
  end
  

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:company])
  # end
  
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :company])
  end

  def after_sign_up_path_for(resource)
    if resource.company?
      new_company_path
    else
      new_user_path
    end
  end

  def check_registration_type
    if session[:registration_type].nil?
      redirect_to choose_registration_type_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
