# frozen_string_literal: true

# Path: app/models/customer.rb
class Customer < ApplicationRecord
  has_many :transactions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :limit, presence: true, numericality: { greater_than: 0 }
  validates :balance, presence: true, numericality: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8, maximum: 22 }
  validates :role, presence: true, inclusion: { in: %w[administrator customer] }
end
