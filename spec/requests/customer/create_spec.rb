# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST - /customers' do
  let(:url) { '/customers' }

  context 'when the request is valid' do
    it 'creates a customer' do
      customer_params = { name: 'John Doe', limit: 1000 }

      post(url, params: { customer: customer_params })

      expect(response).to have_http_status(:created)
      expect(response.parsed_body['message']).to eq('Customer created!')
    end

    it 'creates a customer with the correct attributes' do
      customer_params = { name: 'John Doe', limit: 1000 }

      post(url, params: { customer: customer_params })

      expect(Customer.last.name).to eq('John Doe')
      expect(Customer.last.limit).to eq(1000)
    end
  end

  context 'when the request is invalid' do
    it 'returns an error message if name is not defined' do
      customer_params = { limit: 1000 }

      post(url, params: { customer: customer_params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq("Validation failed: Name can't be blank")
    end

    it 'returns an error message if name is in use' do
      create(:customer, name: 'John Doe', limit: 1000)

      customer_params = { name: 'John Doe', limit: 1000 }

      post(url, params: { customer: customer_params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('The name John Doe is already in use!')
    end

    it 'returns an error message if limit is not defined' do
      customer_params = { name: 'John Doe' }

      post(url, params: { customer: customer_params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Validation failed: Limit must be greater than 0')
    end

    it 'returns an error message if limit is less than 0' do
      customer_params = { name: 'John Doe', limit: -1 }

      post(url, params: { customer: customer_params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Validation failed: Limit must be greater than 0')
    end
  end
end
