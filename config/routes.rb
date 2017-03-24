Rails.application.routes.draw do
  namespace :portal, path: '/' do
    root 'top#index'
    get 'signup' => 'accounts#signup', as: :signup
    resources :accounts, only: [ :new, :create ] do
      patch :send_mail, on: :collection
      get :after_send, on: :collection
      get :thanks, on: :collection
    end
  end
  namespace :customer do
    root 'articles#index', as: :root
    get 'login' => 'sessions#new', as: :login
    resource :session, only: [ :create, :destroy ]
    resource :forgot_password, only: [ :new, :create ] do
      get :after_send
      patch :change_password
    end
    get 'input_password' => 'forgot_passwords#input_password'
    resources :articles
  end
  namespace :admin do
    root 'dashboard#index', as: :root
    get 'login' => 'sessions#new', as: :login
    resource :session, only: [ :create, :destroy ]
  end
end
