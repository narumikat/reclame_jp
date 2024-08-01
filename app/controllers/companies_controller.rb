class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update]
  
  def new
    @company = Company.new
  end

  # def new
  #   @company = @user.companies.build
  # end
  
  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to company_path(@company)
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

  def set_company
    @company = Company.find(params[:id])
  end
  
  # def set_user
  #   @user = User.find(params[:user_id])
  # end

  def company_params
    params.require(:company).permit(
      :company_name, :company_register_number, :company_address, :company_city,
      :company_state, :company_zip_code, :company_country, :company_phone_number,
      :company_website, :company_social_media, :company_description,
      :company_contact_name, :company_contact_email
    )
  end
end
