Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations", omniauth_callbacks: "users/omniauth_callbacks" }

  root 'pages#home'
  get '/dashboard' => 'users#show', as: :user_root

  resources :groups, only: [:new, :create, :show]
  resources :invitations, only: [:create]
  resources :list_items, only: [:create, :destroy]
  resources :memberships, only: [:new, :create]
  resources :users, only: [:new]
end
