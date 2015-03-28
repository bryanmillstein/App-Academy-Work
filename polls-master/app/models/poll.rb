class Poll < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validates :title, uniqueness: true

  belongs_to :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id

  has_many :questions,
    class_name: 'Question',
    foreign_key: :poll_id,
    primary_key: :id,
    dependent: :destroy

  def self.all_question_counts
    polls_with_question_counts = {}
    polls = self.all
      .select("polls.*, COUNT(questions.*) AS question_counts")
      .joins(:questions)
      .joins("JOIN questions.id ON answer_choices.question_id")
      .joins("LEFT OUTER JOIN answer_choices.id ON responses.answer_choice_id")
      .group("polls.id")
    polls.each do |poll|
      polls_with_question_counts[poll.title] = poll.question_counts
    end
    polls_with_question_counts
  end

  after_destroy :log_destroy_action
  def log_destroy_action
    puts "#{self.class} destroyed."
  end
end
