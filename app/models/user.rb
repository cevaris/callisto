class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  has_one :google_account
  has_one :drop_box_account
  has_one :setting
  has_many :resources
  has_many :maps, order: 'id DESC'

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

  def has_google_account?
    !google_account.nil? and !google_account.folder_id.nil?
  end

  def has_drop_box_account?
    !drop_box_account.nil? and !drop_box_account.session_token.nil?
  end

  def request_key
    Digest::MD5.hexdigest(self.email + self.confirmed.to_s + self.password_digest + self.created_at.iso8601)
  end

  private

  def default_values
    self.setting = Setting.new
  end

  def create_remember_token
    self.remember_token ||= SecureRandom.urlsafe_base64
  end
end
