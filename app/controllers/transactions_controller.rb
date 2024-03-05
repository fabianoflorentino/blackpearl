# frozen_string_literal: true

# Controller to handle the transactions
class TransactionsController < ApplicationController
  def create
    TransactionUseCase::Create.new(params[:customer_id], transaction_params).call
    render json: { transaction: 'Transaction successfully created!' }, status: :created
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :kind, :description)
  end
end
