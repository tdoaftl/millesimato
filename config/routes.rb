Rails.application.routes.draw do
  devise_for :users
  root to: "clothings#index"
  resources :clothings, only: :index
  resources :users, only: [:index, :edit, :new, :show]
end
