class StudentAnswer < ApplicationRecord
  belongs_to :student
  belongs_to :question

  validates :response, presence: true
end
