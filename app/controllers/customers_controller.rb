# frozen_string_literal: true

# CustomersController
class CustomersController < ApplicationController
  def index
    render json: { customers: }, status: :ok
  end

  def show
    render json: { customer: }, status: :ok
  end

  def create
    CustomerUseCase::Create.new(customer_params).call
    render json: { message: 'Customer created!' }, status: :created
  end

  private

  def customers
    @customers ||= Customer.all
  end

  def customer
    @customer ||= Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :limit)
  end
end
