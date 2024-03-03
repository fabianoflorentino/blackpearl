# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  rescue_from StandardError, with: :name_in_use
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def name_in_use(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
