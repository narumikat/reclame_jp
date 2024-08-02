class Company < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :complaints

  validates :company_name, :company_city, :company_state, :company_country, presence: true
  validates :company_name, uniqueness: true
  validate :must_have_at_least_one_social_media

  private

  def must_have_at_least_one_social_media
    social_media = company_social_media
    if social_media.blank? || !social_media.values.any?(&:present?)
      errors.add(:company_social_media, "must have at least one social media account")
    end
  end
end
