Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  root 'home#index'
  get 'test', to: 'application#test'

  # around login, sign_up, logout
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'activate', to: 'users#activate'
  get 'sign_up', to: 'users#new', as: :sign_up
  post 'sign_up', to: 'users#create'
end
