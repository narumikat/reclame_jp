class Response < ApplicationRecord
  after_save :update_complaint_status
  
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

  private

  def update_complaint_status
    complaint.update_status
  end
end