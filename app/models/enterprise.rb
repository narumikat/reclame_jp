class Enterprise < ApplicationRecord
  belongs_to :user

  # Validações
  validates :company_name, presence: true
  validates :user_id, presence: true

end
