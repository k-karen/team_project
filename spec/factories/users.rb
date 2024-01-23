# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    age { rand(18..100) }
    biography { Faker::Lorem.sentence }
    password { "aiit-password" }

    trait :with_friends do
      after(:create) do |user|
        create_list(:friendship, 3, user: user)
      end
    end

    trait :activated do
      after(:create) do |user|
        user.update!(activation_state: "active")
      end
    end
  end
end
