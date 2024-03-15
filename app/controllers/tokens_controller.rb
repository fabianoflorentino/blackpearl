# frozen_string_literal: true

# TokensController
class TokensController < ApplicationController
  def create
    token = AuthenticationUseCase::Token.new(params[:email], params[:password]).call

    if token
      render json: { token: }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
