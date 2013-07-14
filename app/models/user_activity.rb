class UserActivity < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :activity
  belongs_to :activity_state
end
