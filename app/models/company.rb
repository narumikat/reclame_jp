class Company < ApplicationRecord
  has_and_belongs_to_many :users


  # Validações
  validates :company_name, presence: true
  validates :user_id, presence: true

end
