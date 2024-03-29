# frozen_string_literal: true

# Module to handle the transaction use case
module TransactionUseCase
  # Class to handle the creation of a transaction
  class Create
    def initialize(customer_id, transaction_params)
      @customer_id = customer_id
      @amount = transaction_params[:amount]
      @kind = transaction_params[:kind]
      @description = transaction_params[:description]
    end

    def call
      transaction = Transaction.new(**set_transaction)
      transaction&.save!

      transaction
    end

    private

    def set_customer
      Customer.find(@customer_id)
    end

    def set_transaction
      {
        customer_id: @customer_id,
        amount: @amount,
        kind: @kind,
        description: @description
      }
    end
  end
end
