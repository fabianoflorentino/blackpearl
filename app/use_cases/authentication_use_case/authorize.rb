# frozen_string_literal: true

module AuthenticationUseCase
  # Authorize
  class Authorize
    def initialize(request)
      @request = request
    end

    def call
      raise SharedErrors::CustomerNotFound unless customer?

      Rails.logger.info("Customer authorized: #{decode[0]['customer_id']}")
    end

    private

    def customer?
      Customer.exists?(id: decode[0]['customer_id'])
    end

    def decode
      JWT.decode(header, rails_secret_key_base, true, algorithm: 'HS256')
    end

    def header
      @request['Authorization'].split.last if @request['Authorization'].present?
    end

    def rails_secret_key_base
      Rails.application.config.secret_key_base
    end
  end
end
