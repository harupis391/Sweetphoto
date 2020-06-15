class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 255 }
  
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy
  
  def notify_comment(current_user)
    unless self.post.user == current_user
        current_user.notifications.find_or_create_by(
          comment_id: self.id,
          post_id: self.post.id,
          visited_id: self.post.user.id,
          action:"comment"
          )
    end
  end
end
