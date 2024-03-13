# frozen_string_literal: true

# Extract controller
class ExtractsController < ApplicationController
  def index
    extract = TransactionUseCase::Extract.new(params[:customer_id]).call

    render json: extract, status: :ok
  end
end
