Rails.application.routes.draw do
  root 'movies#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :movies, only: [:index, :show]
  resources :users, only: [:index, :show]
  resources :posts

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
