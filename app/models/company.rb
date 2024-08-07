class Company < ApplicationRecord
  has_many :companies_users
  has_many :users, through: :companies_users
  has_many :complaints

  validates :company_name, :company_city, :company_state, :company_category, presence: true
  validate :must_have_at_least_one_social_media
  validate :unique_social_media_urls

  COMPANY_CATEGORY = [
  "Empreiteiras",
  "Construção, Demolição e Reforma",
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

  def unique_complaint_companies_count
    complaints.select(:company_id).distinct.count
  end

  def complaints_asnwered_count
    complaints.joins(:responses).count    
  end

  def complaints_unasnwered_count
    complaints.where.not(id: Response.select(:complaint_id)).count
  end

  def complaints_asnwered_percentage
    unique_complaint_companies_count.to_f / complaints.count.to_f * 100
  end

  def complaints_unasnwered_percentage
    complaints_unasnwered_count.to_f / complaints.count.to_f * 100
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
end
