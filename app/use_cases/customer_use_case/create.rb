# frozen_string_literal: true

# CustomerUseCase
module CustomerUseCase
  # Create
  class Create
    def initialize(customer_params)
      @customer_params = customer_params
    end

    def call
      customer = Customer.new(@customer_params)
      customer&.save!

      customer
    end
  end
end
