# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerUseCase::Create do
  let(:customer_params) { attributes_for(:customer) }

  describe '#call' do
    context 'when the customer is valid' do
      it 'creates a new customer' do
        expect { described_class.new(customer_params).call }.to change(Customer, :count).by(1)
      end
    end

    context 'when the customer is invalid' do
      it 'name is required' do
        customer_params[:name] = nil
        expect { described_class.new(customer_params).call }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'email is required' do
        customer_params[:email] = nil
        expect { described_class.new(customer_params).call }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'name already exists' do
        create(:customer, name: customer_params[:name])
        expect { described_class.new(customer_params).call }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'email already exists' do
        create(:customer, email: customer_params[:email])
        expect { described_class.new(customer_params).call }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'password is required' do
        customer_params[:password] = nil
        expect { described_class.new(customer_params).call }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'password is too short' do
        customer_params[:password] = '123'
        expect { described_class.new(customer_params).call }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'password is too long' do
        customer_params[:password] = '1234567890123456789012345678901234567890'
        expect { described_class.new(customer_params).call }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
