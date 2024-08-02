class Response < ApplicationRecord
  belongs_to :complaint
  belongs_to :user
  belongs_to :company

  validates :content, presence: true

  def self.search(search)
    if search
      where('content LIKE ?', "%#{search}%")
    else
      all
    end
  end
end