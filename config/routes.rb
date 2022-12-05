Rails.application.routes.draw do

  get   '/activation/:id/:token', to: 'user_activation#activation_form', as: 'activation'
  match '/activation/:id/:token', to: 'user_activation#activate', via: [ :post, :patch, :put ]

  namespace :admin do
    get '/login', to: 'login#form'
    post '/login', to: 'login#authenticate'
    match '/logout', to: 'login#logout', via: :all
    root 'dashboard#index'
    resources :users
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
