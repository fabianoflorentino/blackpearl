# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST - /authentications/tokens' do
  let(:url) { '/authentication/token' }

  context 'when the request is valid' do
    it 'returns a 200 status code' do
      customer = create(:customer)

      post(url, params: { email: customer.email, password: customer.password })

      expect(response).to have_http_status(:created)
    end

    it 'returns a token' do
      customer = create(:customer)

      post(url, params: { email: customer.email, password: customer.password })
      token = response.parsed_body['token']

      expect(token).not_to be_nil
    end

    it 'returns a token with the correct payload' do
      customer = create(:customer)

      post(url, params: { email: customer.email, password: customer.password })

      token = response.parsed_body['token']
      decoded_token = JWT.decode(token, Rails.application.config.secret_key_base, true, algorithm: 'HS256').first

      expect(decoded_token['customer_id']).to eq(customer.id)
      expect(decoded_token['email']).to eq(customer.email)
      expect(decoded_token['password']).to eq(customer.password)
      expect(decoded_token['exp']).to be_within(1.minute).of(1.hour.from_now.to_i)
    end

    context 'when the request is invalid' do
      it 'returns a 404 status code' do
        post(url, params: { email: 'invalid_email', password: 'invalid_password' })

        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        post(url, params: { email: 'invalid_email', password: 'invalid_password' })

        expect(response.parsed_body['error']).to eq('Customer not found')
      end

      it 'returns an error message when the password is invalid' do
        customer = create(:customer)

        post(url, params: { email: customer.email, password: 'invalid_password' })

        expect(response.parsed_body['error']).to eq('Wrong password!')
      end

      it 'returns an error message when the email is invalid' do
        customer = create(:customer)

        post(url, params: { email: 'invalid_email', password: customer.password })

        expect(response.parsed_body['error']).to eq('Customer not found')
      end
    end
  end
end
