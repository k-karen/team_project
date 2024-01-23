# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    name { Faker::Lorem.word }
    retention_minutes { rand(1..60) }
  end
end
