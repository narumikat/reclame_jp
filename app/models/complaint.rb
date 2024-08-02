class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :responses, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  validates :company_id, presence: true

  def self.search(search)
    if search
      where('title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end