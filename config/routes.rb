Rails.application.routes.draw do
  root "home#index"
  get "/public_key", to: "static#public_key"

  resources :profiles, path: "/u", only: :show do

  end

  resources :posts

  resource :sessions, only: [] do
    collection do
      get "/profile", action: :profile
      get "/settings", action: :settings

      get "/login", action: :login

      get "/register", action: :register
      post "/register", action: :register_post

      delete "/logout", action: :logout

      get "/recovery", action: :recovery
      post "/recovery", action: :confirm_recovery
    end
  end

  namespace :api do
    post "/server_proof_of_work", to: "server_proof_of_works#show"

    resources :posts, only: :show do
      resources :comments, only: %i(index show) do
        resources :reactions, only: :index
      end
      resources :reactions, only: :index
    end

    resources :stories, only: :show do
      resources :comments, only: %i(index show) do
        resources :reactions, only: :index
      end
      resources :reactions, only: :index
    end
  end
end
