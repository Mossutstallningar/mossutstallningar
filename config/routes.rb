Mossutstallningar::Application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'static_pages#start'

  get 'svt', to: 'static_pages#svt', as: 'svt'

  get 'cts', to: redirect('/sidor/cts')

  localized do
    resources :projects, only: [:show]
    resources :pages, only: [:show]
    resources :products, only: [:index, :show]
    resources :takes, only: [:index, :show]

    get 'search', to: 'search#index', as: 'search'

    get 'closed', to: 'static_pages#closed', as: 'closed'
  end
end
