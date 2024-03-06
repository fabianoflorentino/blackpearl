# frozen_string_literal: true

# transaction
FactoryBot.define do
  factory :transaction do
    amount { SecureRandom.random_number(1..100_000) }
    kind { %w[c d].sample }
    description { Faker::Lorem.characters(number: 10) }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end
