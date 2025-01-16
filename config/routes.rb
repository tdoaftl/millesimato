Rails.application.routes.draw do
  devise_for :users
  root to: "clothings#index"
  resources :clothings

    resources :users , only: [:index] do
      collection do
        get 'informations/new', to: 'users#new', as: 'new_information'
        post 'informations', to: 'users#create', as: 'create_information'
        get 'informations/edit', to: 'users#edit', as: 'edit_information'
        patch  'informations', to: 'users#update', as: 'update_information'
  end
end
end