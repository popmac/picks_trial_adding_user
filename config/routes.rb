Rails.application.routes.draw do
  namespace :portal do
    root 'top#index'
  end
end
