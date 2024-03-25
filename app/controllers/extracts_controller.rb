# frozen_string_literal: true

# Extract controller
class ExtractsController < ApplicationController
  before_action :authorize_request

  def index
    render json: extract, status: :ok
  end

  private

  def authorize_request
    AuthenticationUseCase::Authorize.new(request.headers).call
  end

  def extract
    TransactionUseCase::Extract.new(params[:customer_id]).call
  end
end
