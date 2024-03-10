# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST - /customers' do
  let(:customer_params) { attributes_for(:customer) }
  let(:url) { '/customers' }

  context 'when the request is valid' do
    it 'creates a customer' do
      post(url, params: { customer: customer_params })

      expect(response).to have_http_status(:created)
      expect(response.parsed_body['message']).to eq('Customer created!')
    end

    it 'creates a customer with the correct attributes' do
      post(url, params: { customer: customer_params })

      expect(Customer.last.name).to eq(customer_params[:name])
      expect(Customer.last.limit).to eq(customer_params[:limit])
    end
  end

  context 'when the request is invalid' do
    it 'returns an error message if name is not defined' do
      params = {
        limit: customer_params[:limit],
        email: customer_params[:email],
        password: customer_params[:password]
      }

      post(url, params: { customer: params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq("Validation failed: Name can't be blank")
    end

    it 'returns an error message if name is in use' do
      create(:customer, name: 'John Doe')

      params = {
        name: 'John Doe',
        limit: customer_params[:limit],
        email: customer_params[:email],
        password: customer_params[:password]
      }

      post(url, params: { customer: params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Validation failed: Name has already been taken')
    end

    it 'returns an error message if limit is not defined' do
      params = {
        name: customer_params[:name],
        email: customer_params[:email],
        password: customer_params[:password]
      }

      post(url, params: { customer: params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Validation failed: Limit must be greater than 0')
    end

    it 'returns an error message if limit is less than 0' do
      params = {
        name: customer_params[:name],
        limit: -1,
        email: customer_params[:email],
        password: customer_params[:password]
      }

      post(url, params: { customer: params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Validation failed: Limit must be greater than 0')
    end

    it 'returns an error message if email is not defined' do
      params = {
        name: customer_params[:name],
        limit: customer_params[:limit],
        password: customer_params[:password]
      }

      post(url, params: { customer: params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq("Validation failed: Email can't be blank")
    end

    it 'returns an error message if email is in use' do
      create(:customer, email: 'customer@example.com')

      params = {
        name: customer_params[:name],
        limit: customer_params[:limit],
        email: 'customer@example.com',
        password: customer_params[:password]
      }

      post(url, params: { customer: params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Validation failed: Email has already been taken')
    end

    it 'returns an error message if password is not defined' do
      params = {
        name: customer_params[:name],
        limit: customer_params[:limit],
        email: customer_params[:email]
      }

      error_message = "Validation failed: Password can't be blank, Password is too short (minimum is 8 characters)"

      post(url, params: { customer: params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq(error_message)
    end

    it 'returns an error message if password is less than 8 characters' do
      params = {
        name: customer_params[:name],
        limit: customer_params[:limit],
        email: customer_params[:email],
        password: '1234567'
      }

      post(url, params: { customer: params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Validation failed: Password is too short (minimum is 8 characters)')
    end

    it 'returns an error message if password is more than 22 characters' do
      params = {
        name: customer_params[:name],
        limit: customer_params[:limit],
        email: customer_params[:email],
        password: '12345678901234567890123'
      }

      post(url, params: { customer: params })

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Validation failed: Password is too long (maximum is 22 characters)')
    end
  end
end
