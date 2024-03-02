# frozen_string_literal: true

# This controller is used to check if the app is up and running.
class UpController < ApplicationController
  def index
    render json: { status: 'up!' }
  end
end
