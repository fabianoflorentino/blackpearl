# frozen_string_literal: true

# CustomerUseCase
module CustomerUseCase
  # Create
  class Create
    def initialize(customer_params)
      @customer_params = customer_params
    end

    def call
      new_customer.save!
      new_customer
    end

    private

    attr_reader :customer_params

    def new_customer
      Customer.new(customer_params)
    end
  end
end
