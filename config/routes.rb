Rails.application.routes.draw do
  Rails.application.routes.default_url_options[:host] = Rails.application.secrets.dig(:load_balancer_address)

  root "home#index"
  get "/public_key", to: "static#public_key"
  post "/sign", to: "signatures#create"

  resources :profiles, path: "/u", only: :show do

  end

  resources :posts
  resources :cities, only: %i(index)
  resources :identities, only: :create
  resources :peer_infos, only: %i(index show create update destroy) do
    collection do
      post "/search_public_keys", action: :search_public_keys
    end
  end

  resource :sessions, only: [] do
    collection do
      get "/profile", action: :profile
      patch "/profile", action: :profile_post
      get "/settings", action: :settings

      get "/login", action: :login
      post "/login", action: :login_post

      get "/register", action: :register
      post "/register", action: :register_post

      delete "/logout", action: :logout

      get "/recovery", action: :recovery
      post "/recovery", action: :confirm_recovery
    end
  end

  namespace :api do
    post "/server_proof_of_work", to: "server_proof_of_works#show"

    resource :friendship, only: %i(show create destroy update)
    resource :profile, only: :show

    resources :posts, only: %i(show index) do
      resources :comments, only: %i(index show) do
        resources :reactions, only: %i(index create destroy)
      end
      resources :reactions, only: %i(index create destroy)
    end

    resources :stories, only: :show do
      resources :comments, only: %i(index show) do
        resources :reactions, only: %i(index create destroy)
      end
      resources :reactions, only: %i(index create destroy)
    end
  end

  constraints LoggedIn do
    mount Sidekiq::Web => '/sidekiq'
    mount PgHero::Engine => "pghero"
  end
end
