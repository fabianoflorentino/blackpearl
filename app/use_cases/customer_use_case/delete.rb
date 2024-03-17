# frozen_string_literal: true

module CustomerUseCase
  # Delete
  class Delete
    def initialize(id)
      @id = id
    end

    def call
      return customer.destroy! if balance?

      raise SharedErrors::BalanceEmpty
    end

    private

    attr_reader :id

    def customer
      @customer = Customer.includes(:transactions).find(@id)
    end

    def balance?
      customer.balance.zero?
    end
  end
end
