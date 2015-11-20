Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root 'pages#home'
  get '/dashboard' => 'users#show', as: :user_root

  resources :groups, only: [:new, :create, :show]

end
