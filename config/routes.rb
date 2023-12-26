Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get 'users/new'
  get 'users/create'
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'sign_up', to: 'users#new', as: :sign_up
  get 'activate', to: 'users#activate'
  post 'sign_up', to: 'users#create'
  delete 'logout', to: 'sessions#destroy', as: :logout

  root "home#index"

  get 'test', to: 'application#test'
end
