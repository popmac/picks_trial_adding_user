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
end
