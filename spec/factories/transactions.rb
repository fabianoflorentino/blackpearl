# frozen_string_literal: true

# transaction
FactoryBot.define do
  factory :transaction do
    amount { SecureRandom.random_number(100) }
    kind { %w[c d].sample }
    description { Faker::Lorem.characters(number: 10) }
  end
end
