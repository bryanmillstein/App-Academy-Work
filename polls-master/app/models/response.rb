class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  # validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll

  belongs_to :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id

  has_one :question, through: :answer_choice, source: :question


  after_destroy :log_destroy_action
  def log_destroy_action
    puts "#{self.class} destroyed."
  end

  def sibling_responses
      Response.find_by_sql("SELECT
                        all_responses.*
                      FROM
                        (SELECT * FROM answer_choices
                        WHERE id = #{id}) AS the_answer_choice
                      JOIN questions
                        ON the_answer_choice.question_id = questions.id
                      JOIN answer_choices AS all_answers
                        ON questions.id = all_answers.question_id
                      JOIN responses AS all_responses
                        ON all_answers.id = all_responses.answer_choice_id
                      WHERE
                      #{id} IS NULL OR all_responses.id != #{id}")
  end

  #private

    def respondent_has_not_already_answered_question
      if self.sibling_responses.exists?(user_id: self.user_id)
        errors[:base] << "Already answered this question!"
      end
    end

    def author_cannot_respond_to_own_poll
      poll = Poll.joins(:questions => :responses).where("answer_choices.id = #{self.answer_choice_id}")

      return if poll.empty?

      if poll.first.author_id == self.user_id
        errors[:base] << "Can't answer your own poll"
      end
    end
end
