# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::StatementInvalid, with: :customer_limit_reached
  rescue_from SharedErrors::CustomerNotFound, with: :customer_not_found
  rescue_from SharedErrors::WrongPassword, with: :wrong_password
  rescue_from SharedErrors::BalanceEmpty, with: :balance_must_be_zero
  rescue_from JWT::DecodeError, with: :unauthorized_request

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

  def customer_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def wrong_password(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def balance_must_be_zero(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def unauthorized_request(exception)
    render json: { error: 'Unauthorized request' }, status: :unauthorized

    Rails.logger.error(exception.message)
  end
end
