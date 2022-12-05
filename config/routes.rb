Rails.application.routes.draw do

  get   '/activation/:id/:token', to: 'user_activation#activation_form', as: 'activation'
  match '/activation/:id/:token', to: 'user_activation#activate', via: [ :post, :patch, :put ]

  namespace :admin do
    resources :users
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
