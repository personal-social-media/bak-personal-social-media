# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "rails", "~> 6.1.1"
gem "pg", "~> 1.1"
gem "sass-rails", ">= 6"
gem "bootsnap", ">= 1.4.4", require: false

group :development do
  gem "web-console", ">= 4.1.0"
  gem "listen", "~> 3.3"
  gem "spring"
end

# end default rails

group :development do
  gem "annotate", "~> 3.1", ">= 3.1.1"
  gem "foreman", "~> 0.87.2"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "rubocop-rails_config", "~> 1.2", ">= 1.2.1"
  gem "rspec-rails", "~> 4.0", ">= 4.0.2"
  gem "factory_bot_rails", "~> 6.1"
  gem "bundler-audit"
  gem "brakeman"
end

group :production do
  gem "dotenv", "~> 2.7", ">= 2.7.6"
end

group :test do
  gem "database_cleaner", "~> 1.8", ">= 1.8.5"
end

gem "snowpacker", github: "ParamagicDev/snowpacker"
gem "bcrypt", "~> 3.1", ">= 3.1.16"
gem "jb", "~> 0.8.0"
gem "str_enum", "~> 0.2.0"
gem "memoist", "~> 0.16.2"
gem "auto_strip_attributes"
gem "turbo-rails"
gem "falcon"
gem "http"
