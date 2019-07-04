Rails.application.routes.draw do
  devise_for :users, :controllers => {
  	registrations: 'users/registrations',sessions: 'users/sessions',
  	omniauth_callbacks: 'users/omniauth_callbacks',registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'
  resources :items
end
