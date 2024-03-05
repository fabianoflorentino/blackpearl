# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction do
  let(:transaction) { described_class.new }

  it { is_expected.to belong_to(:customer) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  it { is_expected.to validate_presence_of(:kind) }
  it { is_expected.to validate_inclusion_of(:kind).in_array(%w[c d]) }
  it { is_expected.to validate_presence_of(:description) }

  it 'validates the presence of the customer' do
    transaction.customer_id = nil

    transaction.valid?
    expect(transaction.errors[:customer]).to include('must exist')
  end

  it 'validates the amount to be greater than or equal to 0' do
    transaction.amount = -1

    transaction.valid?
    expect(transaction.errors[:amount]).to include('must be greater than 0')
  end

  it 'validates the amount to be greater than 0' do
    transaction.amount = 0

    transaction.valid?
    expect(transaction.errors[:amount]).to include('must be greater than 0')
  end

  it 'validates the amount to be an integer' do
    transaction.amount = 1.5

    transaction.valid?
    expect(transaction.errors[:amount]).to include('must be an integer')
  end

  it 'validates the presence of the kind' do
    transaction.valid?
    expect(transaction.errors[:kind]).to include('is not included in the list')
  end

  it 'validates the presence of the description' do
    transaction.valid?
    expect(transaction.errors[:description]).to include("can't be blank")
  end

  it 'validates the description length' do
    transaction.description = 'a' * 11

    transaction.valid?
    expect(transaction.errors[:description]).to include('is too long (maximum is 10 characters)')
  end

  it 'validates the description has special characters' do
    transaction.description = 'a!'

    transaction.valid?
    expect(transaction.errors[:description]).to include('should not contain special characters')
  end

  it 'validate the description is nil' do
    transaction.description = nil

    transaction.valid?

    expect(transaction.errors[:description]).to include("can't be blank")
  end
end
