class EnterprisesController < ApplicationController
  before_action :set_enterprise, only: [:show, :edit, :update]
  
  def new
    @enterprise = Enterprise.new
  end

  # def new
  #   @enterprise = @user.enterprises.build
  # end
  
  def create
    @enterprise = Enterprise.new(enterprise_params)
    if @enterprise.save
      redirect_to enterprise_path(@enterprise)
    else
      render :new
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    
  end

  private

  def set_enterprise
    @enterprise = Enterprise.find(params[:id])
  end
  
  # def set_user
  #   @user = User.find(params[:user_id])
  # end

  def enterprise_params
    params.require(:enterprise).permit(
      :company_name, :company_register_number, :company_address, :company_city,
      :company_state, :company_zip_code, :company_country, :company_phone_number,
      :company_website, :company_social_media, :company_description,
      :company_contact_name, :company_contact_email
    )
  end
end
