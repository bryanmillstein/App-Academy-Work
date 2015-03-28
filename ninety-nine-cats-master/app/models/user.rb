require 'bcrypt'

class User < ActiveRecord::Base
  validates(:user_name,
            :password_digest,
            presence: true)
  # validates :session_token, uniqueness: true
  validates :password, length: {minimum: 8}, allow_nil: true
  # after_initialize :ensure_session_token

  has_many(
    :cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :session_tokens,
    class_name: "SessionToken",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :cat_rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id,
    primary_key: :id
  )

  def self.find_by_credentials(user_name, password)
    @user = User.find_by(user_name: user_name)
    return nil unless @user && @user.is_password?(password)
    @user
  end

  # def ensure_session_token
  #   self.session_token ||= SecureRandom::urlsafe_base64
  # end

  # def reset_session_token!
  #   # token = SessionToken.find_by(session_token: session[:session_token])
  #   # if !token.nil?
  #     # token.session_token = SecureRandom::urlsafe_base64
  #   # else
  #     # token = SessionToken.new(@user.id, SecureRandom::urlsafe_base64)
  #   # end
  #   # token.save
  #   # return token.session_token
  #   self.session_token = SecureRandom::urlsafe_base64
  #
  #   self.save
  # end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
