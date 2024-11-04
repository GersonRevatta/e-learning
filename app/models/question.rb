class Question < ApplicationRecord
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  has_many :student_answers, dependent: :destroy

  enum question_type: { boolean: 0, single_choice: 1, multiple_choice_single_correct: 2,
                        multiple_choice_some_correct: 3 }

  validates :content, presence: true
  validates :question_type, presence: true

  def correctly_answered?(student_answer)
    case question_type
    when 'boolean'
      correct_answer = answers.find_by(is_correct: true)&.text
      student_answer.response == correct_answer
    when 'single_choice'
      correct_answer = answers.find_by(is_correct: true)&.id.to_s
      student_answer.response == correct_answer
    when 'multiple_choice_single_correct'
      correct_answers = answers.where(is_correct: true).pluck(:id).map(&:to_s)
      student_answer.response.split(',') == correct_answers
    when 'multiple_choice_some_correct'
      correct_answers = answers.where(is_correct: true).pluck(:id).map(&:to_s)
      student_responses = student_answer.response.split(',')
      (correct_answers - student_responses).empty? && (student_responses - correct_answers).empty?
    else
      false
    end
  end
end
