class Response < ApplicationRecord
  include Pundit::Authorization
  after_save :update_complaint_status
  
  belongs_to :complaint
  belongs_to :user
  belongs_to :company
  belongs_to :parent, class_name: 'Response', optional: true
  has_many :responses, class_name: 'Response', foreign_key: 'parent_id', dependent: :destroy

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