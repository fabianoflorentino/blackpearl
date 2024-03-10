# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer do
  let(:customer) { create(:customer) }

  it { is_expected.to have_many(:transactions) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:limit) }
  it { is_expected.to validate_presence_of(:balance) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  it 'validates the presence of the name' do
    customer.name = nil

    customer.valid?
    expect(customer.errors[:name]).to include("can't be blank")
  end

  it 'validates the uniqueness of the name' do
    customer.name = 'Customer'
    customer.save

    new_customer = described_class.new(name: 'Customer')
    new_customer.valid?

    expect(new_customer.errors[:name]).to include('has already been taken')
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

  it 'validates the presence of the email' do
    customer.email = nil

    customer.valid?
    expect(customer.errors[:email]).to include("can't be blank")
  end

  it 'validates the uniqueness of the email' do
    customer.email = 'customer@email.com'
    customer.save

    new_customer = described_class.new(email: 'customer@email.com')
    new_customer.valid?

    expect(new_customer.errors[:email]).to include('has already been taken')
  end

  it 'validates the presence of the password' do
    customer.password = nil

    customer.valid?
    expect(customer.errors[:password]).to include("can't be blank")
  end

  it 'validates the minimum of the password' do
    customer.password = '1234567'

    customer.valid?
    expect(customer.errors[:password]).to include('is too short (minimum is 8 characters)')
  end

  it 'validates the maximum of the password' do
    customer.password = '1234567890123456789012345'

    customer.valid?
    expect(customer.errors[:password]).to include('is too long (maximum is 22 characters)')
  end
end
