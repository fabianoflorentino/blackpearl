# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PATCH - /customers/:id' do
  let(:customer) { create(:customer) }
  let(:authorization) { AuthenticationUseCase::Token.new(customer.email, customer.password).call }
  let(:headers) { { 'Authorization' => "Bearer #{authorization}" } }
  let(:url) { "/customers/#{customer.id}" }

  context 'when the request is valid' do
    it 'updates the customer' do
      customer_params = { name: 'John Doe', limit: 1000 }

      patch(url, headers:, params: { customer: customer_params })

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['message']).to eq('Customer updated!')
    end

    it 'updates the customer with the correct attributes' do
      customer_params = { name: 'John Doe', limit: 1000 }

      patch(url, headers:, params: { customer: customer_params })

      customer.reload

      expect(customer.name).to eq('John Doe')
      expect(customer.limit).to eq(1000)
    end
  end

  context 'when the request is invalid' do
    it 'returns an error message if name is in use' do
      jack = create(:customer, name: 'Jack Sparrow', limit: 1000)
      jack_authorization = AuthenticationUseCase::Token.new(jack.email, jack.password).call
      jack_headers = { 'Authorization' => "Bearer #{jack_authorization}" }

      create(:customer, name: 'Will', limit: 1000)

      customer_params = { name: 'Will', limit: 1000 }

      patch("/customers/#{jack.id}", headers: jack_headers, params: { customer: customer_params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Validation failed: Name has already been taken')
    end

    it 'returns an error message if limit is less than 0' do
      customer_params = { name: 'John Doe', limit: -1 }

      patch(url, headers:, params: { customer: customer_params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Validation failed: Limit must be greater than 0')
    end
  end
end
