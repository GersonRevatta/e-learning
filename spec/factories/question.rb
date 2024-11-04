# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    content { 'MyText' }
    question_type { 0 }
    association :lesson
  end
end
