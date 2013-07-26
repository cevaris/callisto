class UserActivity < ActiveRecord::Base
	MAX_PHOTOS = 6
  attr_accessible :report, :video_url, :user_activity_images_attributes
  
  belongs_to :user
  belongs_to :activity
  belongs_to :activity_state

  has_many :user_activity_images

  validates_uniqueness_of :user_id, :scope => [:activity_id, :id]

  accepts_nested_attributes_for :user_activity_images, :allow_destroy => true    
end
