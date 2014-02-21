Mossutstallningar::Application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'pages#start'

  get 'search', to: 'search#index', as: 'search'
end
