class Student < User
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :lesson_progresses
  has_many :student_answers

  def initialize(attributes = {})
    attributes ||= {}
    super(attributes.merge(role: :student))
  end
end
