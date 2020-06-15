class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, length: { maximum: 255 }
  validates :image, presence: true
  
  mount_uploader :image, PostImageUploader
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  def notify_like(current_user)
    unless self.user == current_user
      current_user.notifications.find_or_create_by(
        post_id: self.id,
        visited_id: self.user.id,
        action: "like"
        )
    end
  end
end
