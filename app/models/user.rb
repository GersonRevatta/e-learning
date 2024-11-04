class User < ApplicationRecord
  enum role: { student: 0, professor: 1 }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
