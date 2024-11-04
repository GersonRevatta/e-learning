FactoryBot.define do
  factory :lesson_progress do
    student { 1 }
    lesson { 1 }
    completed { false }
  end
end
