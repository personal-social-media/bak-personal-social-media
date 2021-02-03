if ENV["RAILS_ENV"] == "production"
  workers Etc.nprocessors

  threads_count = 5
  threads(threads_count, threads_count)

  preload_app!

  rackup DefaultRackup
  environment "production"

  on_worker_boot do
    ActiveRecord::Base.establish_connection
  end
else
  threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
  threads threads_count, threads_count
  port        ENV.fetch("PORT") { 3000 }
  environment ENV.fetch("RAILS_ENV") { "development" }

  plugin :tmp_restart
end
