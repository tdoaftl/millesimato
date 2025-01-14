Rails.application.routes.draw do
  devise_for :users
  root to: "clothings#index"
  resources :clothings, only: :index
end
