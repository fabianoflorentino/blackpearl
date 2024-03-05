# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST - /customers/:id/transactions' do
  let(:customer) { create(:customer) }
  let(:transaction) { attributes_for(:transaction) }

  context 'when the request is valid' do
    it 'returns status code 201' do
      post("/customers/#{customer.id}/transactions", params: { transaction: })

      expect(response).to have_http_status(:created)
    end
  end

  context 'when the request is invalid' do
    it 'returns status code 422 if amount is invalid' do
      post("/customers/#{customer.id}/transactions", params: { transaction: { amount: nil } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if amount is less than 0' do
      post("/customers/#{customer.id}/transactions", params: { transaction: { amount: -1 } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if amount is not integer' do
      post("/customers/#{customer.id}/transactions", params: { transaction: { amount: 1.1 } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if kind is invalid' do
      post("/customers/#{customer.id}/transactions", params: { transaction: { kind: 'x' } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if description is invalid' do
      description = Faker::Lorem.characters(number: 11)

      post("/customers/#{customer.id}/transactions", params: { transaction: { description: } })

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns status code 422 if customer_id is invalid' do
      customer_id = SecureRandom.uuid

      post("/customers/#{customer_id}/transactions", params: { transaction: })

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
