Rails.application.routes.draw do

  root 'movie_pages#home'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :movie_pages, only: [:home, :show]
  resources :users, only: [:index, :show]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
