class CompaniesUser < ApplicationRecord
  belongs_to :company
  belongs_to :user

  validates :role, presence: true
end
