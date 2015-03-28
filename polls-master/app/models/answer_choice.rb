class AnswerChoice < ActiveRecord::Base
  validates :text, :question_id, presence: true
  validates :text, :uniqueness => {:scope => :question}

  belongs_to :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses,
    class_name: "Response",
    foreign_key: :answer_choice_id,
    primary_key: :id,
    dependent: :destroy

  after_destroy :log_destroy_action
  def log_destroy_action
    puts "#{self.class} destroyed."
  end
end

git filter-branch -f --env-filter "GIT_AUTHOR_NAME='Jacob Shorty'; GIT_AUTHOR_EMAIL='jakeshorty@gmail.com'; GIT_COMMITTER_NAME='Bryan Millstein'; GIT_COMMITTER_EMAIL='bryanmillstein@gmail.com';" HEAD
