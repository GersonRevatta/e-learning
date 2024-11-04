# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { 'MyText' }
    description { 'MyString' }
    association :professor
  end
end
