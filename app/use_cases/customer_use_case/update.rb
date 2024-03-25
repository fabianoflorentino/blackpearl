# frozen_string_literal: true

module CustomerUseCase
  # Update class
  class Update
    def initialize(customer_id, customer_params)
      @customer_id = customer_id
      @customer_params = customer_params
    end

    def call
      customer.update!(@customer_params)
      customer
    end

    private

    def customer
      Customer.find(@customer_id)
    end
  end
end
