# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { Customer.new }

  it { should have_many(:transactions) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:limit) }
  it { should validate_presence_of(:balance) }

  it 'should validate the presence of the name' do
    customer.name = nil

    customer.valid?
    expect(customer.errors[:name]).to include("can't be blank")
  end

  it 'should validate the presence of the limit' do
    customer.limit = -1

    customer.valid?
    expect(customer.errors[:limit]).to include('must be greater than 0')
  end

  it 'should validate the presence of the limit' do
    customer.limit = 'string'

    customer.valid?
    expect(customer.errors[:limit]).to include('is not a number')
  end

  it 'should validate the presence of the balance' do
    customer.balance = 'string'

    customer.valid?
    expect(customer.errors[:balance]).to include('is not a number')
  end
end
