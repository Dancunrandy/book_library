Rails.application.routes.draw do
  root "books#index"

  devise_for :users
  resources :users, only: [:show]
  resources :books, only: [:index, :show] do
    resources :borrowings, only: [:create, :destroy]
  end

  resource :session
  resources :passwords, param: :token

  get "up" => "rails/health#show", as: :rails_health_check
  get "users/show"
  get "borrowings/create"
  get "borrowings/destroy"
  get "books/index"
  get "books/show"
end