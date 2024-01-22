Rails.application.routes.draw do
  root 'home#index'
  get 'current_rev', to: 'home#current_rev'
  get 'test', to: 'application#test'

  mount(LetterOpenerWeb::Engine, at: '/letter_opener') if Rails.env.development?

  resources :rooms do
    resources :messages
  end

  

  # around login, sign_up, logout
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'activate', to: 'users#activate'
  get 'sign_up', to: 'users#new', as: :sign_up
  post 'sign_up', to: 'users#create'

  # user settings
  get 'users/settings/edit', to: 'users#edit', as: :edit_user_settings
  patch 'users/settings', to: 'users#update', as: :update_user_settings
  
  resources :users do
    collection do
      resources :friendships, only: [:index, :create, :destroy]
    end
  end

  match '*not_found_path' => 'home#not_found', via: :all
end
