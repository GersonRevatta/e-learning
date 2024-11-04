class LessonProgress < ApplicationRecord
  belongs_to :student
  belongs_to :lesson
  enum status_progress: { in_progress: 0, finish: 1 }

  validates :student_id, presence: true
  validates :lesson_id, presence: true

  def self.can_access_next_lesson?(student_id, current_lesson_id)
    LessonProgress.find_by(student: student_id, lesson: current_lesson_id)&.completed?
  end
end
