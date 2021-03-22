Rails.application.routes.draw do
  Rails.application.routes.default_url_options[:host] = Rails.application.secrets.dig(:load_balancer_address)

  root "home#index"
  get "/public_key", to: "static#public_key"
  get "/authorize_upload", to: "static#authorize_upload"
  post "/sign", to: "signatures#create"

  resources :profiles, path: "/u", only: :show do

  end

  resources :verification_results, only: %i(create update show) do
    collection do
      post "/search", action: :index
    end
  end

  resources :posts, except: :create do
    collection do
      post "/upload", action: :create
    end
  end
  resources :previous_searches, only: %i(index create destroy)
  resources :image_albums, only: %i(index show create update destroy) do
    resources :gallery_elements, only: %i(index) do
      collection do
        post "/upload", action: :create
      end
    end
  end

  resources :gallery_elements, only: :destroy do
    collection do
      get "/all_private_file_names", action: :all_private_file_names
      get "/all_md5_checksums", action: :all_md5_checksums
    end
  end

  resources :cities, only: %i(index)
  resources :identities, only: :create do
    collection do
      post "/ping", action: :ping
    end
  end
  resources :peer_infos, only: %i(index show create update destroy) do
    collection do
      post "/search_public_keys", action: :search_public_keys
    end
  end

  resource :sessions, only: [] do
    collection do
      get "/profile", action: :profile
      patch "/profile_upload", action: :profile_post
      post "/profile_remove_video", action: :profile_remove_video

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
    resources :feed_items, only: %i(create destroy)
    resource :friendship, only: %i(show create destroy update)
    resource :profile, only: :show
    resource :conversations, only: %i(create update)
    resources :messages, only: %i(create update)

    resources :posts, only: %i(show index)

    resources :stories, only: :show

    resources :reactions, only: %i(index create destroy update) do
      collection do
        post "/proof", action: :proof
      end
    end
    resources :comments, only: %i(index show create destroy update)
  end

  namespace :client do
    resources :friendships, only: %i(create destroy update)
    resources :cache_reactions, only: %i(create update destroy) do
      collection do
        post "/search", action: :index
      end
    end

    resources :cache_comments, only: %i(create update destroy)
  end

  constraints LoggedIn do
    mount Sidekiq::Web => '/sidekiq' if ENV["DEVELOPER"].present?
    mount PgHero::Engine => "/pghero"
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin' if ENV["DEVELOPER"].present?
  end
  match "/*match", to: "static#not_found", via: :all, constraints: ->(req) do
    req.path.exclude?('auth/auth0') &&
      req.path.exclude?('packs') &&
      req.path.exclude?('rails')
  end
end
