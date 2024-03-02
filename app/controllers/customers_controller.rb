# frozen_string_literal: true

# CustomersController
class CustomersController < ApplicationController
  def index
    render json: { customers: }, status: :ok
  end

  def show
    render json: { customer: }, status: :ok
  end

  private

  def customers
    @customers ||= Customer.all
  end

  def customer
    @customer ||= Customer.find(params[:id])
  end
end
