class UsersController < ApplicationController
  before_action :user_params, only: [:show, :edit, :update, :destroy]

  def show
    @user = current_user
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
    params.require(:user).permit(:first_name, :last_name, :phone_number, :address, :city,
    :state, :zip_code, :country, :company_name, :company_register_number, :company_address,
    :company_city, :company_state, :company_zip_code, :company_country, :company_phone_number,
    :company_website, :company_social_media, :company_description, :company_contact_name, :company_contact_email)
  end

end
