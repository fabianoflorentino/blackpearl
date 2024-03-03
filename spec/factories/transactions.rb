# frozen_string_literal: true

# transaction
FactoryBot.define do
  factory :transaction do
    amount { SecureRandom.random_number(100) }
    type { %w[c d].sample }
    desciption { 'transaction' }
  end
end
