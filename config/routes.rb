Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets do
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
  namespace :api do
    resources :tweets, only: :show, defaults: { format: 'json' }
  end
  resources :users, only: [:show] do
    collection do
      get 'search'
    end
  end
end
