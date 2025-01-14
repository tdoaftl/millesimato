Rails.application.routes.draw do
  root to: "clothings#index"
  resources :clothings, only: :index
end
