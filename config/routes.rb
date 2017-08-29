Rails.application.routes.draw do
  devise_for :users
  root to: 'clients#new'

  resources :clients, only: [:index, :create, :new, :show]

end
