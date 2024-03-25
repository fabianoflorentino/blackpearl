# frozen_string_literal: true

# TokensController
class TokensController < ApplicationController
  def create
    render json: { token: }, status: :created
  end

  private

  def token
    AuthenticationUseCase::Token.new(params[:email], params[:password]).call
  end
end
