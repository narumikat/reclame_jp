class Response < ApplicationRecord
  belongs_to :complaint
  belongs_to :user

  validates :description, presence: true
  validates :complaint_id, presence: true
  validates :user_id, presence: true

  def self.search(search)
    if search
      where('description LIKE ?', "%#{search}%")
    else
      all
    end
  end
end