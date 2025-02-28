class Company < ApplicationRecord
  include Pundit::Authorization
  has_many :companies_users, dependent: :destroy
  has_many :users, through: :companies_users
  has_many :complaints

  before_validation :normalize_phone_number
  before_save :capitalize_name

  validates :company_name, :company_city, :company_prefecture, :company_category, presence: true
  validate :must_have_at_least_one_social_media
  validate :unique_social_media_urls
  validate :phone_number_format

  has_one_attached :company_logo
  has_one_attached :company_banner
  rating

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

  COMPANY_PREFECTURE = [
    'Aichi', 'Akita', 'Aomori', 'Chiba', 'Ehime', 'Fukui', 'Fukuoka', 'Fukushima', 'Gifu', 'Gunma', 'Hiroshima', 'Hokkaido',
    'Hyogo', 'Ibaraki', 'Ishikawa', 'Iwate', 'Kagawa', 'Kagoshima', 'Kanagawa', 'Kochi', 'Kumamoto', 'Kyoto', 'Mie', 'Miyagi',
    'Miyazaki', 'Nagano', 'Nagasaki', 'Nara', 'Niigata', 'Oita', 'Okayama', 'Okinawa', 'Osaka', 'Saga', 'Saitama', 'Shiga', 'Shimane',
    'Shizuoka', 'Tokushima', 'Tokyo', 'Tottori', 'Toyama', 'Wakayama', 'Yamagata', 'Yamaguchi', 'Yamanashi'
  ]

  validates :company_prefecture, presence: true, inclusion: { in: COMPANY_PREFECTURE }
  validates :company_category, presence: true, inclusion: { in: COMPANY_CATEGORY }


  def complaints_unanswered_count
    complaints.where.not(id: Response.select(:complaint_id)).count
  end

  def complaints_answered_percentage
    return 0 if complaints_count.zero?
    answered_complaints_count.to_f / complaints_count.to_f * 100
  end

  def company_score
    return 10 if complaints_count.zero?
    score = complaints_answered_percentage
    (score / 10.0).round(1)
  end

  private

  def must_have_at_least_one_social_media
    social_media = company_social_media
    if social_media.blank? || !social_media.values.any?(&:present?)
      errors.add(:company_social_media, "deve ter pelo menos uma rede social")
    end
  end

  def unique_social_media_urls
    urls = company_social_media.values.reject(&:blank?)
    return if urls.empty?

    existing_urls = Company.where.not(id: self.id)
                           .where("company_social_media ?| array[:keys]", keys: urls)
                           .pluck(:company_social_media)

    existing_urls.each do |existing|
      existing.each do |platform, url|
        if company_social_media[platform] == url
          errors.add(:company_social_media, "URL #{url} de #{platform} deve ser única")
        end
      end
    end
  end

  def capitalize_name
    self.company_name = self.company_name.titleize if self.company_name.present?
  end

  def normalize_phone_number
    return if company_phone_number.blank?

    digits = company_phone_number.gsub(/\D/, '')
    # Se for um número de telefone fixo que falta o "0", adiciona o "0"
    if digits.length == 9 && digits[0] != '0'
      digits = '0' + digits
    end

    if digits.start_with?('0')
      if digits.length == 10 # Telefone fixo (ex: 03-1234-5678)
        self.company_phone_number = digits.gsub(/(\d{2})(\d{4})(\d{4})/, '\1 \2 \3')
      elsif digits.length == 11 # Celular (ex: 090-1234-5678)
        self.company_phone_number = digits.gsub(/(\d{3})(\d{4})(\d{4})/, '\1 \2 \3')
      else
        errors.add(:company_phone_number, 'número inválido')
      end
    else
      errors.add(:company_phone_number, 'número inválido')
    end
  end

  def phone_number_format
    return if company_phone_number.blank?
    fixed_line_regex = /\A0\d{1,4} \d{1,4} \d{4}\z/
    mobile_regex = /\A0[789]0 \d{4} \d{4}\z/

    unless company_phone_number.match?(fixed_line_regex) || company_phone_number.match?(mobile_regex)
      errors.add(:company_phone_number, 'deve ser um número de telefone japonês válido')
    end
  end
end
