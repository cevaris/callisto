class User < ActiveRecord::Base
	ADMIN = 'admin'
	SUPER_ADMIN = 'super_admin'
	DEFAULT = 'default'
	
	acts_as_follower
	acts_as_taggable_on
	acts_as_followable


	has_secure_password
	before_save :default_values

  attr_accessible :email, :name, :password, :password_confirmation, :avatar, :role

  has_one  :setting
  has_many :activities
  has_many :user_activities

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, 
  	styles: { 
  		icon: '50x50>', 
			thumb: '100x100>', 
			square: '200x200#', 
			medium: '500x500>',
			large: '700x700>' 
		}
  	
  before_save do |user|
    user.email = user.email.downcase
  end

  before_save :create_remember_token
  before_create :default_values

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, if: :password_digest_changed?


  def request_key
    Digest::MD5.hexdigest(self.email + self.confirmed.to_s + self.password_digest + self.created_at.iso8601)
  end
  
  def admin?
  	[User::ADMIN, User::SUPER_ADMIN].include? self.role
  end

  def activities_accepted
  	self.user_activities.where(activity_state_id: ActivityState.find_by_name(ActivityState::ACCEPTED)).limit(20)
  end

  def activities_following
  	user_ids = self.following_by_type('User').pluck(:id)
  	UserActivity.where(user_id: user_ids).order("created_at DESC").limit(20)
  end

  def activities_watching
  	self.following_by_type('Activity').limit(20)
  end

  private

  def default_values
    self.setting = Setting.new
  end

  def create_remember_token
    self.remember_token ||= SecureRandom.urlsafe_base64
  end
end
