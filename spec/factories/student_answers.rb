FactoryBot.define do
  factory :student_answer do
    student { 1 }
    question { 1 }
    response { "MyText" }
    correct { false }
  end
end
