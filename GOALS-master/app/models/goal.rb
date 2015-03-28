class Goal < ActiveRecord::Base
  validates :title, :user, :privacy, presence: true
  validates :privacy, inclusion: ["Private", "Public"]

  after_initialize :default_completion_status_to_false

  belongs_to :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :goals

  def default_completion_status_to_false
    self.completion_status = false
  end

end
