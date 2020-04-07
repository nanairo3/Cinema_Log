# frozen_string_literal: true

Rails.application.routes.draw do
  root 'movies#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :movies, only: %i[index show]
  resources :users, only: %i[index show]

  resources :posts, only: %i[show destroy edit update]
  resources :movies, only: [:show] do
    resources :posts, only: %i[new create]
  end

  resources :posts do
    resource :like, only: %i[create destroy]
  end

  resources :search, only: %i[index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
