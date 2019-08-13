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
  	resources :images
    resources :purchases do
      collection do
        get 'pay'
      end
    end
  end

  resources :users
end
