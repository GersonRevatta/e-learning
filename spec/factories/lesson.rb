# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    name { 'MyText' }
    association :course
    is_public { false }
  end
end
