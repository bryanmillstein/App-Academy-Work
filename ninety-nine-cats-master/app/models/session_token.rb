class SessionToken < ActiveRecord::Base
  validates :user_id, :session_token, presence: true
  validates :session_token, uniqueness: true
  after_initialize :ensure_session_token

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

end
