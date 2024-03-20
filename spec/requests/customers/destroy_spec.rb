# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE - /customer' do
  let(:customer) { create(:customer, balance: 0) }
  let(:authorization) { AuthenticationUseCase::Token.new(customer.email, customer.password).call }
  let(:headers) { { 'Authorization' => "Bearer #{authorization}" } }
  let(:url) { '/customers' }

  describe 'DELETE /customers/:id' do
    context 'when the customer exists' do
      it 'deletes the customer' do
        delete("#{url}/#{customer.id}", headers:)

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to include('message' => 'Customer deleted!')
      end
    end

    context 'when the customer does not exist' do
      it 'returns 404' do
        not_found_customer = SecureRandom.uuid

        delete("#{url}/#{not_found_customer}")

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
