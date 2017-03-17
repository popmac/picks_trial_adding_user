Rails.application.routes.draw do
  namespace :portal, path: '/' do
    root 'top#index'
  end
end
