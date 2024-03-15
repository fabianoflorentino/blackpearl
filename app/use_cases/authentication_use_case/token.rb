# frozen_string_literal: true

module AuthenticationUseCase
  # Token
  class Token
    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      validate_customer
      password_valid?
      generate_token(payload)
    end

    private

    def customer
      @customer = Customer.find_by(email: @email)
    end

    def validate_customer
      raise ActiveRecord::RecordNotFound unless customer
    end

    def password_valid?
      raise ActiveRecord::RecordInvalid unless customer.password == @password
    end

    def payload
      {
        customer_id: customer.id,
        email: customer.email,
        password: customer.password,
        exp: 1.hour.from_now.to_i
      }
    end

    def generate_token(payload)
      JWT.encode(payload, Rails.application.credentials.secret_key_base)
    end
  end
end
