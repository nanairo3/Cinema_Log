Rails.application.routes.draw do
  root 'movies#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :movies, only: [:index, :show]
  resources :users, only: [:index, :show]
  
  resources :posts, only: [:show, :destroy, :edit, :update]
  resources :movies, only: [:show] do
    resources :posts, only: [:new, :create]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
