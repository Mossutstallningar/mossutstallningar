Mossutstallningar::Application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'static_pages#start'

  localized do
    resources :projects, only: [:show]
    resources :pages, only: [:show]
    resources :takes, only: [:index, :show]

    get 'search', to: 'search#index', as: 'search'
  end
end
