Rails.application.routes.draw do
  devise_for :users
  
  # API Routes
  namespace :api do
    namespace :v1 do
      # User management (admin only)
      resources :users, except: [:new, :edit]
      
      # Current user profile
      resource :profile, only: [:show, :update, :destroy]
      
      # Health check
      get :health, to: 'base#health'
    end
  end
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: proc { [200, {}, ['{"message": "Welcome to KataUser API"}']] }
end
