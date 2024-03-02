# frozen_string_literal: true

# Transaction model which is used to interact with the database.
class Transaction < ApplicationRecord
  belongs_to :customer

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :type, presence: true, inclusion: { in: %w[c d] }
  validates :description, presence: true, length: { maximum: 10 }
end
