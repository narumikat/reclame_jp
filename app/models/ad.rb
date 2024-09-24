class Ad < ApplicationRecord
  has_one_attached :image

  ADS_TYPE = ['Banner', 'Banner-sm', 'Card', 'Sidecard'].freeze
  LOCATION = ['home', 'index company', 'index complaints', 'about', 'contact', 'privacy', 'terms'].freeze

  validates :title, presence: true
  validates :ad_type, presence: true, inclusion: { in: ADS_TYPE }
end
