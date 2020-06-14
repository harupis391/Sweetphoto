class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 255 }
  
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy
  
  def notify_comment(current_user)
    unless self.post.user == current_user
        self.notifications.find_or_create_by(
          post_id: self.post.id,
          visitor_id: current_user.id,
          visited_id: self.post.user.id,
          action:"comment"
          )
    end
  end
end
