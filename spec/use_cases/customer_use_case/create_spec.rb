# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerUseCase::Create do
  let(:customer_params) { { name: 'John Doe', limit: 1000 } }

  describe '#call' do
    context 'when name is not in use' do
      it 'creates a new customer' do
        expect { described_class.new(customer_params).call }.to change(Customer, :count).by(1)
      end

      it 'returns the created customer' do
        customer = described_class.new(customer_params).call

        expect(customer).to be_a(Customer.new.class)
      end

      it 'returns the created customer with the correct name' do
        expect(described_class.new(customer_params).call.name).to eq('John Doe')
      end
    end

    context 'when name is in use' do
      it 'raises a NameInUse error' do
        Customer.create!(name: 'John Doe', limit: 1000)

        expect { described_class.new(customer_params).call }.to raise_error(SharedErrors::NameInUse)
      end
    end
  end
end
