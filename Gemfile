source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem 'dotenv-rails'
gem "factory_bot_rails", "~> 6.4"
gem "rubocop", "~> 1.75"
gem 'sidekiq'
gem "faker", "~> 3.5"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem 'rspec-rails'
  gem "rubocop-rails-omakase", require: false
  gem 'shoulda-matchers', '~> 6.5'
end
