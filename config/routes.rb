Rails.application.routes.draw do
  devise_for :users
  root to: "clothings#index"
  resources :clothings do
    collection do
      post 'search_all'        # /clothings/search にアクセス可能
      get 'brand_check'   
    end
    member do
      patch :update_visibility
    end
    resources :purchases, only: [:new, :create, :index]
  end



    resources :users , only: [:index] do
      collection do
        get 'informations/new', to: 'users#new', as: 'new_information'
        post 'informations', to: 'users#create', as: 'create_information'
        get 'informations/edit', to: 'users#edit', as: 'edit_information'
        patch  'informations', to: 'users#update', as: 'update_information'
  end
end
end