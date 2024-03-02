# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'is valid with valid attributes' do
    customer = Customer.new(name: 'John', limit: 1000, balance: 0)
    expect(customer).to be_valid
  end

  it 'is not valid without a name' do
    customer = Customer.new(name: nil, limit: 1000, balance: 0)
    expect(customer).to_not be_valid
  end

  it 'is not valid without a limit' do
    customer = Customer.new(name: 'John', limit: nil, balance: 0)
    expect(customer).to_not be_valid
  end

  it 'is not valid without a balance' do
    customer = Customer.new(name: 'John', limit: 1000, balance: nil)
    expect(customer).to_not be_valid
  end
end
