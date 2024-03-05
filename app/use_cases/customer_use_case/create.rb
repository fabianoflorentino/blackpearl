# frozen_string_literal: true

# CustomerUseCase
module CustomerUseCase
  # Create
  class Create
    def initialize(customer_params)
      @customer_params = customer_params
    end

    def call
      raise SharedErrors::NameInUse, customer_params[:name] if name_exists?

      new_customer.save!
      new_customer
    end

    private

    attr_reader :customer_params

    def new_customer
      Customer.new(customer_params)
    end

    def name_exists?
      Customer.exists?(name: customer_params[:name])
    end
  end
end
