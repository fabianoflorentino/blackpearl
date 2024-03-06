# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionUseCase::Extract do
  let(:customer) { create(:customer) }

  describe '#call' do
    it 'returns the extracted data' do
      transaction = create(:transaction, customer_id: customer.id)
      extract = described_class.new(customer.id).call

      expect(extract[:extract][:balance][:total]).to eq(customer.balance)
      expect(extract[:extract][:balance][:date].class).to eq(ActiveSupport::TimeWithZone)
      expect(extract[:extract][:balance][:limit]).to eq(customer.limit)
      expect(extract[:extract][:transactions].first[:id]).to eq(transaction.id)
      expect(extract[:extract][:transactions].first[:kind]).to eq(transaction.kind)
      expect(extract[:extract][:transactions].first[:date]).to eq(transaction.created_at)
      expect(extract[:extract][:transactions].first[:amount]).to eq(transaction.amount)
      expect(extract[:extract][:transactions].first[:description]).to eq(transaction.description)
    end

    it 'returns the last 10 transactions' do
      10.times { create(:transaction, customer_id: customer.id) }

      extract = described_class.new(customer.id).call

      expect(extract[:extract][:transactions].count).to eq(10)
    end

    it 'returns the last 10 transactions ordered by created_at' do
      10.times { create(:transaction, customer_id: customer.id) }

      extract = described_class.new(customer.id).call
      transactions = extract[:extract][:transactions]

      expect(transactions).to eq(transactions.sort_by { |t| t[:date] }.reverse)
    end

    it 'returns the empty array when there are no transactions' do
      extract = described_class.new(customer.id).call

      expect(extract[:extract][:transactions]).to eq([])
    end

    it 'raises an error if the customer does not exist' do
      expect { described_class.new(0).call }.to raise_error do |error|
        expect(error).to be_a(ActiveRecord::RecordNotFound)
        expect(error.message).to eq("Couldn't find Customer with 'id'=0")
      end
    end
  end
end
