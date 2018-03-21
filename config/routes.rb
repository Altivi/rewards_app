Rails.application.routes.draw do
  root 'rewards#index', as: :root
  devise_for :accounts

  resource :account, only: [:show, :edit, :update]
  resources :rewards, only: [:index]
end
