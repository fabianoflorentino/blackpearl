# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET - /customers/:id/extracts' do
  let(:customer) { create(:customer) }
  let(:url) { "/customers/#{customer.id}/extracts" }

  context 'when the request is valid' do
    it 'returns status code 200' do
      get(url)

      expect(response).to have_http_status(:ok)
    end

    it 'returns the customer extract' do
      get(url)

      expect(response.parsed_body['extract']['balance'].keys).to match_array(%w[total date limit])
      expect(response.parsed_body['extract']['transactions']).to eq([])
    end

    it 'returns the customer extract with transactions' do
      transactions = create_list(:transaction, 10, customer:)
      transaction_attributes = %w[id kind date amount description]

      get(url)

      response_transactions_last_id = response.parsed_body['extract']['transactions'].last[:id]

      expect(response.parsed_body['extract']['transactions'].size).to eq(10)
      expect(response.parsed_body['extract']['transactions'].last.keys).to match_array(transaction_attributes)
      expect(response_transactions_last_id).to be_in(transactions.map(&:id))
    end

    it 'raises an error when the customer does not exist' do
      get("/customers/#{SecureRandom.uuid}/extracts")

      expect(response).to have_http_status(:not_found)
    end
  end
end
