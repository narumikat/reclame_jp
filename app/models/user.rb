class User < ApplicationRecord
  include Pundit::Authorization
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

  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 20 }

  def company?
    self.is_company
  end

  def role_in_company(company)
    companies_users.find_by(company: company)&.role
  end

  def total_complaints_count
    return 0 if complaints.blank?
    complaints.count
  end

  def unique_complaint_companies_count
    return 0 if complaints.blank?
    complaints.select(:company_id).distinct.count
  end

  def complaints_answered_count
    complaints.joins(:responses).count
  end

  def complaints_unanswered_count
    complaints.where.not(id: Response.select(:complaint_id)).count
  end

  def complaints_answered_percentage
    unique_complaint_companies_count.to_f / complaints.count.to_f * 100
  end

  def username_protected
    if self.username.blank?
      self.username = "Anonimo"
    else
      self.username = "#{username[0..1]}#{'*' * 4}"
    end
  end
end
