# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PATCH - /customers/:id' do
  let(:customer) { create(:customer) }
  let(:url) { "/customers/#{customer.id}" }

  context 'when the request is valid' do
    it 'updates the customer' do
      customer_params = { name: 'John Doe', limit: 1000 }

      patch(url, params: { customer: customer_params })

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['message']).to eq('Customer updated!')
    end

    it 'updates the customer with the correct attributes' do
      customer_params = { name: 'John Doe', limit: 1000 }

      patch(url, params: { customer: customer_params })

      customer.reload

      expect(customer.name).to eq('John Doe')
      expect(customer.limit).to eq(1000)
    end
  end

  context 'when the request is invalid' do
    it 'returns an error message if name is in use' do
      jack = create(:customer, name: 'Jack Sparrow', limit: 1000)
      create(:customer, name: 'Will', limit: 1000)

      customer_params = { name: 'Will', limit: 1000 }

      patch("/customers/#{jack.id}", params: { customer: customer_params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('The name Will is already in use!')
    end

    it 'returns an error message if limit is less than 0' do
      customer_params = { name: 'John Doe', limit: -1 }

      patch(url, params: { customer: customer_params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Validation failed: Limit must be greater than 0')
    end
  end
end