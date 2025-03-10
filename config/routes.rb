Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  devise_for :users
  namespace :api do
    namespace :v1 do
      defaults format: :json do
        get 'users/info', 'user_controller#info'
        post 'users/login', 'user_controller#login'
        get 'orders/get_shortest_path', 'orders_controller#get_shortest_path'
        get 'orders/djisktra', 'orders_controller#djisktra'
        resources :users
        resources :orders
        resources :warehouses
      end
    end
  end
end
