class User < ActiveRecord::Base
  include Amistad::FriendModel
  
	ADMIN = 'admin'
	SUPER_ADMIN = 'super_admin'
	DEFAULT = 'default'
	
  acts_as_taggable_on


	has_secure_password
	before_save :default_values

  attr_accessible :email, :password, :password_confirmation, 
  								:avatar, :role, :first_name, :last_name

  has_one  :setting
  has_many :activities
  has_many :user_activities
  has_many :authorizations

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
    user.first_name.strip!
    user.last_name.strip!
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

  def as_json(options)
    # this example ignores the user's options
    super(only: [:id, :first_name, :last_name, :email, :role, :avatar, :authtoken])
  end

  def name
  	"#{self.first_name} #{self.last_name}"
  end

  def stats
  	stats = {}
  	# Activities
  	stats[:accepted]  =  self.activities_accepted.count
  	stats[:completed] =  self.activities_completed.count

  	stats
  end

  def update_authtoken
    self.authtoken = SecureRandom.uuid + '-' + SecureRandom.uuid.reverse
  end

  def request_key
    Digest::MD5.hexdigest(self.email + self.confirmed.to_s + self.password_digest + self.created_at.iso8601)
  end
  
  def admin?
  	[User::ADMIN, User::SUPER_ADMIN].include? self.role
  end

  def activities_completed
  	# Activities I have completed
  	self.user_activities.where(state: UserActivity::COMPLETED)
  end

  def activities_accepted
  	# Activities I have accepted
  	self.user_activities.where(state: UserActivity::ACCEPTED)
  end

  private

  def default_values
    self.setting = Setting.new
  end

  def create_remember_token
    self.remember_token ||= SecureRandom.urlsafe_base64
    self.authtoken ||= update_authtoken
  end

  
end
