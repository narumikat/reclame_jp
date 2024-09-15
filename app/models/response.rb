class Response < ApplicationRecord
  include Pundit::Authorization
  after_save :update_complaint_status
  
  belongs_to :complaint
  belongs_to :user
  belongs_to :company
  belongs_to :parent, class_name: 'Response', optional: true
  has_many :responses, class_name: 'Response', foreign_key: 'parent_id', dependent: :destroy

  validates :content, presence: true
  acts_as_favoritor

  def self.search(search)
    if search
      where('content LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def favorite(user)
    unless favorited_by?(user)
    user.favorite(self)
    update_column(:likes_count, likes_count + 1)
    end
  end

  def unfavorite(user)
    if favorited_by?(user)
      user.unfavorite(self)
      update_column(:likes_count, likes_count - 1)
    end
  end

  def favorited_by?(user)
    Favorite.exists?(favoritor: user, favoritable: self)
  end

  private

  def update_complaint_status
    complaint.update_status
  end
end