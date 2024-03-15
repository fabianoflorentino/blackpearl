# frozen_string_literal: true

# TokensController
class TokensController < ApplicationController
  def create
    token = AuthenticationUseCase::Token.new(params[:email], params[:password]).call

    render json: { token: }, status: :created
  end
end
