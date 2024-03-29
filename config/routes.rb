# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get 'up' => 'rails/health#show', as: :rails_health_check
  get 'up', to: 'up#index'

  # Defines the root path route ("/")
  # root "posts#index"

  # Define a resource route for customers
  resources :customers, only: %i[index show create update destroy] do
    resources :transactions, only: %i[create]
    resources :extracts, only: %i[index]
  end

  resource :authentication, only: %i[index] do
    resource :token, only: %i[create]
  end
end
