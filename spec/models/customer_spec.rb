# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { described_class.new }

  it { is_expected.to have_many(:transactions) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:limit) }
  it { is_expected.to validate_presence_of(:balance) }

  it 'validates the presence of the name' do
    customer.name = nil

    customer.valid?
    expect(customer.errors[:name]).to include("can't be blank")
  end

  it 'validates limit is greater than 0' do
    customer.limit = -1

    customer.valid?
    expect(customer.errors[:limit]).to include('must be greater than 0')
  end

  it 'validates limit is not a string' do
    customer.limit = 'string'

    customer.valid?
    expect(customer.errors[:limit]).to include('is not a number')
  end

  it 'validates balance is not a string' do
    customer.balance = 'string'

    customer.valid?
    expect(customer.errors[:balance]).to include('is not a number')
  end
end
