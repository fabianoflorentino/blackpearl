# frozen_string_literal: true

module CustomerUseCase
  # Delete
  class Delete
    def initialize(id)
      @id = id
    end

    def call
      return customer.destroy! if customer.balance.zero?

      raise SharedErrors::BalanceEmpty
    end

    private

    attr_reader :id

    def customer
      Customer.includes(:transactions).find(@id)
    end
  end
end
