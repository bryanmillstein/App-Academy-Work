require 'bcrypt'

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum:6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :goals,
    class_name: "Goal",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :user,
    dependent: :destroy

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    user && user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(value)
    @password = value
    self.password_digest = BCrypt::Password.create(value)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  private

    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end

end
