class UsersController < ApplicationController
  before_action :user_params, only: [:create]
  skip_before_action :authenticate_user!, only: [:show]

  def home
  end

  # def new
  #   @user = User.new
  # end

  def create
    @user = User.new(user_params)
    @user.is_company = Company.find(session[:registration_type])
    @user.save
    redirect_to user_path(@user)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :admin,
      :is_company,
      :first_name,
      :last_name,
      :phone_number,
      :address,
      :city,
      :state,
      :zip_code,
      :country,
      :reset_password_token,
      :reset_password_sent_at,
      :remember_created_at,
      :sign_in_count,
      :current_sign_in_at,
      :last_sign_in_at,
      :current_sign_in_ip,
      :last_sign_in_ip,
      :confirmation_token,
      :confirmed_at,
      :confirmation_sent_at,
      :unconfirmed_email
    )
  end
  
end
