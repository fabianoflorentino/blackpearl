# frozen_string_literal: true

# CustomersController
class CustomersController < ApplicationController
  before_action :authorize_request, except: :create

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

  def update
    CustomerUseCase::Update.new(params[:id], customer_params).call
    render json: { message: 'Customer updated!' }, status: :ok
  end

  def destroy
    CustomerUseCase::Delete.new(params[:id]).call
    render json: { message: 'Customer deleted!' }, status: :ok
  end

  private

  def customers
    @customers ||= Customer.all
  end

  def customer
    @customer ||= Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :limit, :balance, :email, :password)
  end

  def authorize_request
    AuthenticationUseCase::Authorize.new(request.headers).call
  end
end
