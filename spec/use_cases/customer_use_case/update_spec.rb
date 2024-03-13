# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerUseCase::Update do
  let(:customer) { create(:customer) }
  let(:customer_params) { { name: 'John Doe', limit: 1000, email: 'customer@email.com', password: 'password123' } }

  describe '#call' do
    it 'returns the updated customer' do
      update_customer = described_class.new(customer.id, customer_params).call

      expect(update_customer).to eq(customer)
    end

    it 'updates the customer with the given parameters' do
      described_class.new(customer.id, customer_params).call

      customer.reload

      expect(customer.name).to eq(customer_params[:name])
      expect(customer.limit).to eq(customer_params[:limit])
      expect(customer.email).to eq(customer_params[:email])
      expect(customer.password).to eq(customer_params[:password])
    end

    it 'raises an error if the customer id is nil' do
      customer_id = nil

      expect { described_class.new(customer_id, customer_params).call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'raises an error if the customer id is invalid' do
      customer_id = 0

      expect { described_class.new(customer_id, customer_params).call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'raises an error if the customer does not exist' do
      expect { described_class.new(0, customer_params).call }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
