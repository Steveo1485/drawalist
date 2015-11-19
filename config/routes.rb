Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  get '/dashboard' => 'users#show', as: :user_root

end
