class UserActivity < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :activity
  belongs_to :activity_state


  validates_uniqueness_of :user_id, :scope => [:activity_id, :id]
end
