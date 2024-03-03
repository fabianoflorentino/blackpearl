# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE - /customer' do
  let(:customer) { create(:customer) }
  let(:url) { '/customers' }

  describe 'DELETE /customers/:id' do
    context 'when the customer exists' do
      it 'deletes the customer' do
        delete("#{url}/#{customer.id}")

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to include('message' => 'Customer deleted!')
      end
    end

    context 'when the customer does not exist' do
      it 'returns 404' do
        delete("#{url}/0")

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
