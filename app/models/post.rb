class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, length: { maximum: 255 }
  validates :image, presence: true
  
  mount_uploader :image, PostImageUploader
end
