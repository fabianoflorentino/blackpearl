# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:transaction) { described_class.new }

  it { is_expected.to belong_to(:customer) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_inclusion_of(:type).in_array(%w[c d]) }
  it { is_expected.to validate_presence_of(:description) }

  it 'validates the presence of the customer' do
    transaction.valid?
    expect(transaction.errors[:customer]).to include('must exist')
  end

  it 'validates the presence of the amount' do
    transaction.valid?
    expect(transaction.errors[:amount]).to include('must be greater than 0')
  end

  it 'validates the presence of the type' do
    transaction.valid?
    expect(transaction.errors[:type]).to include('is not included in the list')
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
end
