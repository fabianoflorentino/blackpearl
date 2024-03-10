# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::StatementInvalid, with: :customer_limit_reached
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def customer_limit_reached(exception)
    render json: { error: 'Customer limit reached' }, status: :unprocessable_entity

    Rails.logger.error(exception.message)
  end

  def record_invalid(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end
