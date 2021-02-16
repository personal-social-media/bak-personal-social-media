Sidekiq::Throttled.setup!

return if Rails.env.test?
Redis.exists_returns_integer = false

Sidekiq.configure_server do |config|
  config.redis = RedisService::Url.build_sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = RedisService::Url.build_sidekiq_config
end

schedule_file = 'config/schedule.yml'

if Sidekiq.server?
  Sidekiq::Cron::Job.destroy_all!
end

if File.exist?(schedule_file) && Sidekiq.server? && Rails.env.production?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end

unless Rails.env.production?
  Sidekiq.redis { |conn| conn.flushdb }
end

if Rails.env.production?
  Sidekiq.default_worker_options = { 'backtrace' => 20 }

  Sidekiq.configure_server do |config|
    config.error_handlers << Proc.new {|ex| Bugsnag.notify(ex) }
  end
end