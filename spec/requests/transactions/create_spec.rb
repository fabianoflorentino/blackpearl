# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST - /customers/:id/transactions' do
  let(:customer) { create(:customer) }
  let(:transaction) { attributes_for(:transaction) }
  let(:authorization) { AuthenticationUseCase::Token.new(customer.email, customer.password).call }
  let(:headers) { { 'Authorization' => "Bearer #{authorization}" } }
  let(:url) { "/customers/#{customer.id}/transactions" }

  context 'when the request is valid' do
    it 'returns status code 201' do
      post(url, headers:, params: { transaction: })

      expect(response).to have_http_status(:created)
    end
  end

  context 'when the request is invalid' do
    it 'returns status code 422 if amount is invalid' do
      post(url, headers:, params: { transaction: { amount: nil } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if amount is less than 0' do
      post(url, headers:, params: { transaction: { amount: -1 } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if amount is not integer' do
      post(url, headers:, params: { transaction: { amount: 1.1 } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if kind is invalid' do
      post(url, headers:, params: { transaction: { kind: 'x' } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if description is invalid' do
      description = Faker::Lorem.characters(number: 11)

      post(url, headers:, params: { transaction: { description: } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if description has special characters' do
      description = '!@#$%^&**()[]_+'

      post(url, headers:, params: { transaction: { description: } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if description is nil' do
      description = nil

      post(url, headers:, params: { transaction: { description: } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if customer_id is invalid' do
      customer_id = SecureRandom.uuid

      url = "/customers/#{customer_id}/transactions"

      post(url, headers: { 'Authorization' => 'invalid_token' }, params: { transaction: })

      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body['error']).to eq('Unauthorized request')
    end
  end
end
