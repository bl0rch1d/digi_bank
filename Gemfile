# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby(File.read('.ruby-version').strip)

gem 'rails', '~> 7.0.3', '>= 7.0.3.1'

gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'haml-rails', '~> 2.0'
gem 'jsbundling-rails'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sprockets-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'brakeman', '~> 5.2', require: false
  gem 'bundler-audit', '~> 0.9', require: false
  gem 'bundler-leak', '~> 0.3.0'
  gem 'factory_bot_rails', '~> 6.2', require: false
  gem 'ffaker', '~> 2.21', require: false
  gem 'lefthook', '~> 1.0', '>= 1.0.5'
  gem 'pry', '~> 0.14'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rubocop', '~> 1.31', require: false
  gem 'rubocop-md', '~> 1.0', require: false
  gem 'rubocop-performance', '~> 1.14', require: false
  gem 'rubocop-rails', '~> 2.15', require: false
  gem 'rubocop-rspec', '~> 2.12', require: false
end

group :development do
  gem 'annotate', '~> 3.2'
end

group :test do
  gem 'rspec-rails', '~> 5.1'
  gem 'shoulda-matchers', '~> 5.1'
  gem 'simplecov', '~> 0.21', require: false
end
