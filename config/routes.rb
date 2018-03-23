Rails.application.routes.draw do
  root 'rewards#index', as: :root
  devise_for :accounts

  resource :account, only: [:edit, :update]
  resources :rewards, only: [:index]

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :account, only: [:show, :update]
      resource :session, only: [:create, :destroy]
      resources :rewards, only: [:index]
    end
  end
end
