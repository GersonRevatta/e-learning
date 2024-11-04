class Lesson < ApplicationRecord
  belongs_to :course
  has_many :questions, dependent: :destroy
  has_many :lesson_progresses

  validates :name, presence: true
  validates :approval_threshold, numericality: { greater_than_or_equal_to: 0 }

  def approved_by?(student)
    questions.all? do |question|
      question_answered_correctly?(question, student)
    end
  end

  def question_answered_correctly?(_question, _student)
    true
  end
end
