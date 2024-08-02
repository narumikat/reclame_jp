class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :company, optional: true 
  has_many :responses, dependent: :destroy

  validates :title, presence: true
  validates :comment, presence: true
  validates :user_id, presence: true

  def self.search(search)
    if search
      where('title LIKE ? OR comment LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end