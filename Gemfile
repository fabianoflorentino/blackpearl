# frozen_string_literal: true

source 'https://rubygems.org'

ruby File.read('.ruby-version').split('-').last.strip

gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

gem 'bcrypt', '~> 3.1', '>= 3.1.20'
gem 'bootsnap', require: false
gem 'jsonapi-serializer', '~> 2.2.0'
gem 'jwt', '~> 2.8', '>= 2.8.1'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'tzinfo-data', '~> 1.2024', '>= 1.2024.1'

group :development, :test do
  gem 'brakeman', '~> 6.0.1', require: false
  gem 'debug'
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker', '~> 3.2.0'
  gem 'rspec', '~> 3.13'
  gem 'rspec-rails', '~> 6.1', '>= 6.1.1'
  gem 'rubocop', '~> 1.61.0'
  gem 'rubocop-performance', '~> 1.20.0'
  gem 'rubocop-rails', '~> 2.23.1'
  gem 'rubocop-rspec', '~> 2.27.0'
  gem 'rubocop-shopify', '~> 2.15.1'
  gem 'shoulda-matchers', '~> 5.3'
end
