Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      defaults format: :json do
        get 'users/info', 'user_controller#info'
        post 'users/login', 'user_controller#login'
        resources :users
        resources :orders
      end
    end
  end
end
