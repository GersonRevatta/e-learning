class Course < ApplicationRecord
  belongs_to :professor
  has_many :lessons, dependent: :destroy
  has_many :students, through: :enrollments

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def approved_by?(student)
    lessons.all? { |lesson| lesson.approved_by?(student) }
  end
end
