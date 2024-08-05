class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
        #  :confirmable usar depois para ocnfirmar o email do user
has_many :companies_users
has_many :companies, through: :companies_users
has_many :responses
has_many :complaints

  def company?
    self.is_company
  end

  def unique_complaint_companies_count
    complaints.select(:company_id).distinct.count
  end

  def complaints_asnwered_count
    complaints.joins(:responses).count    
  end

  def complaints_unasnwered_count
    complaints.where.not(id: Response.select(:complaint_id)).count
  end

  def unique_complaints_asnwered_count
    complaints.joins(:responses).select(:company_id).distinct.count
  end
end
