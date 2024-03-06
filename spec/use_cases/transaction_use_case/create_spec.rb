# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionUseCase::Create do
  let(:customer) { create(:customer) }
  let(:transaction_params) { attributes_for(:transaction) }

  describe '#call' do
    context 'when the transaction is valid' do
      it 'creates a new transaction' do
        transaction = described_class.new(customer.id, transaction_params).call

        expect(transaction).to have_attributes(
          customer_id: customer.id,
          amount: transaction_params[:amount],
          kind: transaction_params[:kind],
          description: transaction_params[:description]
        )
      end

      it 'returns the created transaction' do
        transaction = described_class.new(customer.id, transaction_params).call

        expect(transaction).to be_persisted
      end

      it 'persists the transaction' do
        expect { described_class.new(customer.id, transaction_params).call }.to change(Transaction, :count).by(1)
      end
    end

    context 'when the transaction is invalid' do
      context 'when the amount is invalid' do
        it 'raises an error if amount is nil' do
          transaction_params = {
            amount: nil,
            kind: 'c',
            description: 'Test'
          }

          expect { described_class.new(customer.id, transaction_params).call }.to raise_error do |error|
            expect(error).to be_a(ActiveRecord::RecordInvalid)
            expect(error.record.errors[:amount]).to include("can't be blank")
          end
        end

        it 'raises an error if amount is not a number' do
          transaction_params = {
            amount: 'invalid',
            kind: 'c',
            description: 'Test'
          }

          expect { described_class.new(customer.id, transaction_params).call }.to raise_error do |error|
            expect(error).to be_a(ActiveRecord::RecordInvalid)
            expect(error.record.errors[:amount]).to include('is not a number')
          end
        end

        it 'raises an error if amount is negative' do
          transaction_params = {
            amount: -1,
            kind: 'c',
            description: 'Test'
          }

          expect { described_class.new(customer.id, transaction_params).call }.to raise_error do |error|
            expect(error).to be_a(ActiveRecord::RecordInvalid)
            expect(error.record.errors[:amount]).to include('must be greater than 0')
          end
        end

        it 'raises an error if amount is a float' do
          transaction_params = {
            amount: 1.5,
            kind: 'c',
            description: 'Test'
          }

          expect { described_class.new(customer.id, transaction_params).call }.to raise_error do |error|
            expect(error).to be_a(ActiveRecord::RecordInvalid)
            expect(error.record.errors[:amount]).to include('must be an integer')
          end
        end
      end

      context 'when the kind is invalid' do
        it 'raises an error if kind is nil' do
          transaction_params = {
            amount: 1,
            kind: nil,
            description: 'Test'
          }

          expect { described_class.new(customer.id, transaction_params).call }.to raise_error do |error|
            expect(error).to be_a(ActiveRecord::RecordInvalid)
            expect(error.record.errors[:kind]).to include("can't be blank")
          end
        end

        it 'raises an error if kind is invalid' do
          transaction_params = {
            amount: 1,
            kind: 'invalid',
            description: 'Test'
          }

          expect { described_class.new(customer.id, transaction_params).call }.to raise_error do |error|
            expect(error).to be_a(ActiveRecord::RecordInvalid)
            expect(error.record.errors[:kind]).to include('is not included in the list')
          end
        end
      end

      context 'when the description is invalid' do
        it 'raises an error if description is nil' do
          transaction_params = {
            amount: 1,
            kind: 'c',
            description: nil
          }

          expect { described_class.new(customer.id, transaction_params).call }.to raise_error do |error|
            expect(error).to be_a(ActiveRecord::RecordInvalid)
            expect(error.record.errors[:description]).to include("can't be blank")
          end
        end

        it 'raises an error if description is too long' do
          transaction_params = {
            amount: 1,
            kind: 'c',
            description: 'a' * 11
          }

          expect { described_class.new(customer.id, transaction_params).call }.to raise_error do |error|
            expect(error).to be_a(ActiveRecord::RecordInvalid)
            expect(error.record.errors[:description]).to include('is too long (maximum is 10 characters)')
          end
        end

        it 'raises an error if description has special characters' do
          transaction_params = {
            amount: 1,
            kind: 'c',
            description: 'Test!'
          }

          expect { described_class.new(customer.id, transaction_params).call }.to raise_error do |error|
            expect(error).to be_a(ActiveRecord::RecordInvalid)
            expect(error.record.errors[:description]).to include('should not contain special characters')
          end
        end
      end
    end
  end
end
