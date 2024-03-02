# frozen_string_literal: true

# Path: app/models/customer.rb
class Customer < ApplicationRecord
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
  validates :limit, presence: true, numericality: { greater_than: 0 }
  validates :balance, presence: true, numericality: true
end
