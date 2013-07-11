class UserActivity < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :activity
  has_one 	 :activity_state
end
