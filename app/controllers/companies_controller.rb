class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update]
  before_action :check_company_user, only: [:new, :create, :join] 
  skip_before_action :authenticate_user!, only: [:index, :show]

  COMPANY_CATEGORY = Company::COMPANY_CATEGORY
  
  def index
    @companies = Company.all
    @new_companies = Complaint.where(company_id: nil).where.not(new_company_name: [nil, ''])
  end
  def new
    @company = Company.new
  end
  
  def create
    @company = Company.new(company_params)
    if company_params[:company_social_media].values.all?(&:blank?)
      flash[:alert] = "Please fill out at least one social media field."
      render :new
    else
      if @company.save
        role = session[:role] || params[:role] 
        if role.present?
          CompaniesUser.create!(user: current_user, company: @company, role: role)
          session.delete(:role)
          redirect_to company_path(@company), notice: 'Company was successfully created.'
        else
          @company.destroy
          flash[:alert] = "Role can't be blank"
          render :new
        end
      else
        flash[:alert] = 'Failed to save the company: ' + @company.errors.full_messages.to_sentence
        render :new
      end
    end
  end

  
  def join
    # join to a existing company
  end

  def show
    @company = Company.find(params[:id])
    @complaints = @company.complaints.order(created_at: :desc)
    @complaint = Complaint.new
  end

  def edit
    
  end

  def update
    
  end

  def destroy

  end

  private

  def set_company
    @company = Company.find(params[:id])
  end
  
  def company_params
    params.require(:company).permit(
      :company_name, :company_register_number, :company_address, :company_city,
      :company_state, :company_zip_code, :company_country, :company_phone_number,
      :company_website, :company_description, :company_category,
      :company_contact_name, :company_contact_email, company_social_media: [:facebook, :twitter, :linkedin, :instagram, :youtube, :tiktok],

    )
  end
  

  def check_company_user
    unless current_user.company?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
