# frozen_string_literal: true

# customer
FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    limit { SecureRandom.random_number(10_000) }
    balance { SecureRandom.random_number(10_000) }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
