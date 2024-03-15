# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationUseCase::Token do
  let(:email) { 'test@example.com' }
  let(:password) { 'password1234' }

  describe '#call' do
    it 'generates a token with the correct payload' do
      customer = create(:customer, email:, password:)

      token = described_class.new(email, password).call
      decoded_token = JWT.decode(token, Rails.application.config.secret_key_base, true, algorithm: 'HS256').first

      expect(decoded_token['customer_id']).to eq(customer.id)
      expect(decoded_token['email']).to eq(customer.email)
      expect(decoded_token['password']).to eq(customer.password)
      expect(decoded_token['exp']).to be_within(1.minute).of(1.hour.from_now.to_i)
    end

    it 'raises an error if the customer is not found' do
      expect { described_class.new(email, password).call }.to raise_error(SharedErrors::CustomerNotFound)
    end

    it 'raises an error if the password is incorrect' do
      create(:customer, email:, password: 'password1234')

      expect { described_class.new(email, 'wrongpassword').call }.to raise_error(SharedErrors::WrongPassword)
    end
  end
end
