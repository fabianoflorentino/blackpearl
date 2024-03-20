# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET - /customers' do
  let(:url) { '/customers' }

  context 'when there are customers' do
    it 'returns a list of customers' do
      customers = create_list(:customer, 10)
      authorization = AuthenticationUseCase::Token.new(customers.first.email, customers.first.password).call
      headers = { 'Authorization' => "Bearer #{authorization}" }

      get(url, headers:)

      response_body = response.parsed_body['customers']

      expect(response).to have_http_status(:ok)
      expect(response_body.count).to eq(10)
      expect(response_body.first.keys).to match_array(customers.first.attributes.keys)
    end

    it 'returns a single customer' do
      customer = create(:customer)
      authorization = AuthenticationUseCase::Token.new(customer.email, customer.password).call
      headers = { 'Authorization' => "Bearer #{authorization}" }

      get("#{url}/#{customer.id}", headers:)

      response_body = response.parsed_body['customer']

      expect(response).to have_http_status(:ok)
      expect(response_body.keys).to match_array(customer.attributes.keys)
    end

    it 'returns attributes for a single customer' do
      customer = create(:customer)
      authorization = AuthenticationUseCase::Token.new(customer.email, customer.password).call
      headers = { 'Authorization' => "Bearer #{authorization}" }

      get("#{url}/#{customer.id}", headers:)

      response_body = response.parsed_body['customer']

      expect(response_body.keys).to match_array(customer.attributes.keys)
      expect(response_body['id']).to eq(customer.id)
      expect(response_body['name']).to eq(customer.name)
      expect(response_body['limit']).to eq(customer.limit)
      expect(response_body['balance']).to eq(customer.balance)
    end

    it 'returns only one customer' do
      customers = create(:customer)
      authorization = AuthenticationUseCase::Token.new(customers.email, customers.password).call
      headers = { 'Authorization' => "Bearer #{authorization}" }

      get(url, headers:)

      response_body = response.parsed_body['customers']

      expect(response).to have_http_status(:ok)
      expect(response_body.count).to eq(1)
    end
  end

  context 'when there are no customers' do
    it 'returns a 401' do
      get("#{url}/1")

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when there is an error' do
    it 'returns a 500' do
      customer = create(:customer)
      authorization = AuthenticationUseCase::Token.new(customer.email, customer.password).call
      headers = { 'Authorization' => "Bearer #{authorization}" }

      allow(Customer).to receive(:all).and_raise(StandardError)

      get(url, headers:)

      expect(response).to have_http_status(:server_error)
    end
  end
end
