# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    association :room
    association :user
    content { Faker::Lorem.sentence }
  end
end
