# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerUseCase::Update do
  let(:customer) { create(:customer) }
  let(:customer_params) { { name: 'John Doe', limit: 1000 } }

  describe '#call' do
    it 'updates the customer with the given parameters' do
      described_class.new(customer.id, customer_params).call

      customer.reload

      expect(customer.name).to eq('John Doe')
      expect(customer.limit).to eq(1000)
    end

    it 'raises an error if the customer does not exist' do
      expect { described_class.new(0, customer_params).call }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
