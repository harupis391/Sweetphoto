class Notification < ApplicationRecord

  ACTION_VALUES = ["like", "follow", "comment"]
  validates :action,  presence: true, inclusion: {in:ACTION_VALUES}
  validates :checked, inclusion: {in: [true,false]}
  
  belongs_to :visitor, class_name: 'User'
  belongs_to :visited, class_name: 'User'
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
end
