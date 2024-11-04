class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :course

  enum status_enrollment: { in_progress: 0, completed: 1, approved: 2 }

  validates :status, presence: true
end
