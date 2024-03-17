# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationUseCase::Authorize do
  let(:customer) { create(:customer) }
  let(:token) { AuthenticationUseCase::Token.new(customer.email, customer.password).call }

  describe '#call' do
    context 'when the customer exists' do
      it 'returns true' do
        request = { 'Authorization' => "Bearer #{token}" }

        expect(described_class.new(request).call).to be_truthy
      end
    end

    context 'when the customer does not exist' do
      it 'raises an error' do
        rails_secret_key_base = Rails.application.secrets.secret_key_base
        invalid_customer_params = { email: 'invalid@email.com', password: 'invalid_password' }

        token = JWT.encode({ **invalid_customer_params }, rails_secret_key_base)
        request = { 'Authorization' => "Bearer #{token}" }

        expect { described_class.new(request).call }.to raise_error(SharedErrors::CustomerNotFound)
      end
    end

    context 'when the JWT decoding fails' do
      it 'raises an error with the error message' do
        request = { 'Authorization ' => 'Bearer invalid_token' }

        expect { described_class.new(request).call }.to raise_error(JWT::DecodeError)
      end
    end
  end
end
