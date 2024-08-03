class Company < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :complaints

  validates :company_name, :company_city, :company_state, presence: true
  validate :must_have_at_least_one_social_media
  validate :unique_social_media_urls

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
