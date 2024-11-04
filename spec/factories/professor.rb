# frozen_string_literal: true

FactoryBot.define do
  factory :professor do
    name { 'MyText' }
    email { Faker::Internet.email(name: name) }
  end
end
