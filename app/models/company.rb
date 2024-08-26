class Company < ApplicationRecord
  include Pundit::Authorization
  has_many :companies_users
  has_many :users, through: :companies_users
  has_many :complaints

  validates :company_name, :company_city, :company_state, :company_category, presence: true
  validate :must_have_at_least_one_social_media
  validate :unique_social_media_urls

  has_one_attached :company_logo
  has_one_attached :company_banner

  before_save :capitalize_name

  COMPANY_CATEGORY = [
  "Empreiteiras",
  "Construção",
  "Demolição e Reforma",
  "Educação",
  "Entretenimento",
  "Moda e Beleza",
  "Saúde",
  "Serviços",
  "Tecnologia",
  "Veículos e Acessórios",
  "Viagens e Turismo",
  "Móveis e Decoração",
  "Seguradoras",
  "Agencias de Emprego",
  "Bancos e Financeiras",
  "Telefonia, Tv e Internet",
  "Alimentos e Bebidas",
  "Supermercados",
  "Transporte",
  "Varejo",
  "Outros"]

  validates :company_category, presence: true, inclusion: { in: COMPANY_CATEGORY }

  # def capitalize_name
  #   company_name.titleize
  # end
  
  def total_complaints_count
    complaints.count
  end

  def complaints_answered_count
    complaints.joins(:responses).distinct.count
  end

  def complaints_unanswered_count
    complaints.where.not(id: Response.select(:complaint_id)).count
  end

  def complaints_answered_percentage
    return 0 if total_complaints_count.zero?
    complaints_answered_count.to_f / total_complaints_count.to_f * 100
  end

  def company_score
    return 0 if total_complaints_count.zero?
    
    score = complaints_answered_percentage

    scaled_score = (score / 10.0).round(2)
    
    scaled_score
  end  

  private

  def must_have_at_least_one_social_media
    social_media = company_social_media
    if social_media.blank? || !social_media.values.any?(&:present?)
      errors.add(:company_social_media, "must have at least one social media account")
    end
  end

  def unique_social_media_urls
    company_social_media.each do |platform, url|
      next if url.blank?
      if Company.where("company_social_media @> ?", { platform => url }.to_json).where.not(id: self.id).exists?
        errors.add(:company_social_media, "URL #{url} for #{platform} must be unique")
      end
    end
  end

  def capitalize_name
    self.company_name = self.company_name.titleize if self.company_name.present?
  end
end
