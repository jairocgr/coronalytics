Rails.application.routes.draw do

  get   '/activation/:id/:token', to: 'user_activation#activation_form', as: 'activation'
  match '/activation/:id/:token', to: 'user_activation#activate', via: [ :post, :patch, :put ]

  namespace :admin do
    get '/login', to: 'login#form'
    post '/login', to: 'login#authenticate'
    match '/logout', to: 'login#logout', via: :all
    root 'dashboard#index'
    resources :users
    resources :vaccination_numbers, only: [ :index ]
    resources :srags
    post '/process/srag/:id', to: 'srags#ingest', as: 'process_srag'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
