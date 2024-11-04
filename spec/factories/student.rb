# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    name { 'MyText' }
    email { Faker::Internet.email(name: name) }
  end
end
