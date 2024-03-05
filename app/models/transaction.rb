# frozen_string_literal: true

# Transaction model which is used to interact with the database.
class Transaction < ApplicationRecord
  belongs_to :customer

  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :kind, presence: true, inclusion: { in: %w[c d] }
  validates :description, presence: true, length: { maximum: 10 }

  validate :handle_description_characters_special

  private

  def handle_description_characters_special
    return unless /[^a-zA-Z0-9\s]/.match?(description)

    errors.add(:description, 'should not contain special characters')
  end
end
