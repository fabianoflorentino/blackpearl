# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:transaction) { Transaction.new }

  it { should belong_to(:customer) }
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }
  it { should validate_presence_of(:type) }
  it { should validate_inclusion_of(:type).in_array(%w[c d]) }
  it { should validate_presence_of(:description) }

  it 'should validate the presence of the customer' do
    transaction.valid?
    expect(transaction.errors[:customer]).to include('must exist')
  end

  it 'should validate the presence of the amount' do
    transaction.valid?
    expect(transaction.errors[:amount]).to include('must be greater than 0')
  end

  it 'should validate the presence of the type' do
    transaction.valid?
    expect(transaction.errors[:type]).to include('is not included in the list')
  end

  it 'should validate the presence of the description' do
    transaction.valid?
    expect(transaction.errors[:description]).to include("can't be blank")
  end

  it 'should validate the description length' do
    transaction.description = 'a' * 11

    transaction.valid?
    expect(transaction.errors[:description]).to include('is too long (maximum is 10 characters)')
  end
end
