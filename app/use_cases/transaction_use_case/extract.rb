# frozen_string_literal: true

# Extract use case
module TransactionUseCase
  # Extract class
  class Extract
    def initialize(customer_id)
      @customer_id = customer_id
    end

    def call
      extract
    end

    private

    def extract
      {
        extract: {
          balance: {
            total: customer.balance,
            date: Time.zone.now,
            limit: customer.limit
          },
          transactions: transactions.map do |transaction|
            {
              id: transaction.id,
              kind: transaction.kind,
              date: transaction.created_at,
              amount: transaction.amount,
              description: transaction.description
            }
          end
        }
      }
    end

    def transactions
      transactions ||= Transaction.includes(:customer).where(customer_id: @customer_id)
      transactions.order(created_at: :desc).limit(10)
    end

    def customer
      Customer.find(@customer_id)
    end
  end
end
