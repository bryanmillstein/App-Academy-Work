class User < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many :authored_polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id,
    dependent: :destroy

  has_many :responses,
      class_name: 'Response',
      foreign_key: :user_id,
      primary_key: :id


  def completed_polls
    user_responses_join =
      "LEFT OUTER JOIN (SELECT * FROM responses WHERE user_id = #{id})
      AS user_responses ON answer_choices.id = user_responses.answer_choice_id"

    polls = Poll.all
      .select("polls.*")
      .joins(:questions => :answer_choices)
      .joins(user_responses_join)
      .group("polls.id")
      .having("COUNT(user_responses.*) = COUNT(DISTINCT questions.*)")

    polls
  end

  after_destroy :log_destroy_action
  def log_destroy_action
    puts "#{self.class} destroyed."
  end
end
