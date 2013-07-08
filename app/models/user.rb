class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  has_one :setting

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

  private

  def default_values
    self.setting = Setting.new
  end

  def create_remember_token
    self.remember_token ||= SecureRandom.urlsafe_base64
  end
end
