class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :company, optional: true 
  has_many :responses, dependent: :destroy

  validates :title, presence: true
  validates :comment, presence: true
  validates :user_id, presence: true
  enum status: { pending: 0, answered: 1 }

  accepts_nested_attributes_for :company

  def self.search(search)
    if search
      where('title LIKE ? OR comment LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def update_status
    if responses.any?
      answered!
    else
      pending!
    end
  end
end