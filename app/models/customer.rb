# frozen_string_literal: true

# Path: app/models/customer.rb
class Customer < ApplicationRecord
  validates :name, presence: true
  validates :limit, presence: true
  validates :balance, presence: true
end
