class UserActivity < ActiveRecord::Base

	# Privacy
	FRIENDS = 'Friends'
	ONLY_ME = 'Only Me'
	PUBLIC  = 'Public'

  ACCEPTED  = 'Accepted'
  COMPLETED = 'Completed'
  FORFEITED = 'Forfeited'

	MAX_PHOTOS = 6
  attr_accessible :report, :video_url, :user_activity_images_attributes, :state
  
  belongs_to :user
  belongs_to :activity

  has_many :user_activity_images

  validates_uniqueness_of :user_id, scope: [:activity_id]

  accepts_nested_attributes_for :user_activity_images, :allow_destroy => true    



  def can_view? user

  	# Rails.logger.info "User: #{user.inspect}"
		return true if (self.privacy == UserActivity::PUBLIC)
  	
  	if user # If logged in
			return true if (self.user.id == user.id) # If I am the owner
			return true if ((self.privacy == UserActivity::FRIENDS) and (self.user.friend_with? user))
	  	return true if (user.role == User::SUPER_ADMIN)
  	end
  	
  	false

  end

end
