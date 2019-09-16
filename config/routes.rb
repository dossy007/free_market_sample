Rails.application.routes.draw do
  devise_for :users, :controllers => {
  	omniauth_callbacks: 'users/omniauth_callbacks',registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'
  resources :items do
  	collection do
  		get 'search'
  	end
    namespace :api do
      resources :items,only: [:update,:destroy], defaults: {format: 'json'}
    end
  	resources :images
    resources :cards do
      collection do
        post 'pay'
      end
    end
  end

  resources :category, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end
  resources :users do
    collection do
      get 'sell_item'
    end
  end
end
