# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerUseCase::Delete do
  describe '#call' do
    let(:customer) { create(:customer) }
    let(:use_case) { described_class.new(customer.id) }

    it 'deletes the customer' do
      create_list(:customer, 3)

      customer = create(:customer, balance: 0)

      expect { described_class.new(customer.id).call }.to change(Customer, :count).by(-1)
    end

    it 'deletes all transactions associated with the customer' do
      customer = create(:customer, balance: 0)
      create_list(:transaction, 5, amount: 5, kind: 'c', customer_id: customer.id)
      create_list(:transaction, 5, amount: 5, kind: 'd', customer_id: customer.id)

      described_class.new(customer.id).call

      transactions = Transaction.where(customer_id: customer.id)

      expect(transactions).to be_empty
    end

    it 'does not delete transactions associated with other customers' do
      customer = create(:customer, balance: 0)
      other_customer = create(:customer)

      create_list(:transaction, 5, amount: 5, kind: 'c', customer_id: customer.id)
      create_list(:transaction, 5, amount: 5, kind: 'd', customer_id: customer.id)

      create_list(:transaction, 5, amount: 5, kind: 'c', customer_id: other_customer.id)

      described_class.new(customer.id).call

      other_transactions = Transaction.where(customer_id: other_customer.id)
      other_customer_transactions_count = Transaction.where(customer_id: other_customer.id).count

      expect(other_transactions).not_to be_empty
      expect(other_customer_transactions_count).to eq(5)
    end

    it 'raises an error if the customer does not exist' do
      expect { described_class.new(0).call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'raises an error if the customer has a balance' do
      customer = create(:customer, balance: 100)

      expect { described_class.new(customer.id).call }.to raise_error(SharedErrors::BalanceEmpty)
    end
  end
end
