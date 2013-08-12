class UserActivity < ActiveRecord::Base

	# Privacy
	FRIENDS = 'FRIENDS'
	ONLY_ME = 'ONLY_ME'
	PUBLIC  = 'PUBLIC'

	MAX_PHOTOS = 6
  attr_accessible :report, :video_url, :user_activity_images_attributes
  
  belongs_to :user
  belongs_to :activity
  belongs_to :activity_state

  has_many :user_activity_images

  validates_uniqueness_of :user_id, :scope => [:activity_id, :id]

  accepts_nested_attributes_for :user_activity_images, :allow_destroy => true    

  def can_view? user

  	Rails.logger.info "User: #{user.inspect}"
  	# If user is not logged in
  	return false unless user
  	Rails.logger.info "User: #{user.inspect}"
		return true if (self.privacy == UserActivity::PUBLIC)
		return true if (self.user.id == user.id)
		return true if ((self.privacy == UserActivity::FRIENDS) and (self.user.friend_with? user))
  	return true if (user.role == User::SUPER_ADMIN)
  	
  	false

  end

end
