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
  acts_as_favoritor

  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 20 }, format: { without: /\s/, message: "não pode conter espaços" }

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
    complaints.joins(:responses).distinct.count(:id)
  end

  def complaints_unanswered_count
    complaints.where.not(id: Response.select(:complaint_id)).count
  end

  def complaints_answered_percentage
    return 0 if complaints.count == 0
    (complaints_answered_count.to_f / complaints.count.to_f) * 100
  end
  

  def username_protected
    if self.username.blank?
      self.username = "Anonimo"
    else
      self.username = "#{username[0..1]}#{'*' * 4}"
    end
  end

  # VALIDAÇÃO DE EMAIL
  FORBIDDEN_EMAILS = %w[gmail.com yahoo.com hotmail.com outlook.com icloud.com hotmail.com.br yahoo.com.br outlook.com.br uol.com.br bol.com.br terra.com.br ig.com.br]
  validate :email_domain, if: :company?

  private

  def email_domain
    domain = email.split("@").last
    if FORBIDDEN_EMAILS.include?(domain)
      errors.add(:email, "Este não é permitido, por favor use um email corporativo")
    end
  end
end
