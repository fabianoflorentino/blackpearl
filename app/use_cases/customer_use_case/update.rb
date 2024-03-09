# frozen_string_literal: true

module CustomerUseCase
  # Update class
  class Update
    def initialize(customer_id, customer_params)
      @customer_id = customer_id
      @customer_params = customer_params
    end

    def call
      raise SharedErrors::NameInUse, @customer_params[:name] if name_exists?

      customer.update!(@customer_params)
    end

    private

    def customer
      @customer ||= Customer.find(@customer_id)
    end

    def name_exists?
      Customer.exists?(name: @customer_params[:name])
    end
  end
end
