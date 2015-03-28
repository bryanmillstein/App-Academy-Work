class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  belongs_to :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id

  has_many :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id,
    dependent: :destroy

  has_many :responses, through: :answer_choices, source: :responses

  def results
  choice_counts = self
    .answer_choices
    .select("answer_choices.*, COUNT(responses.*) AS responses_count")
    .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
    .group("answer_choices.id")

    choices_with_counts = {}
    choice_counts.each do |answer_choice|
      choices_with_counts[answer_choice.text] = answer_choice.responses_count
    end

    choices_with_counts
  end

  after_destroy :log_destroy_action
  def log_destroy_action
    puts "#{self.class} destroyed."
  end
end
