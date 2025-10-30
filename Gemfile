source 'http://rubygems.org'

gem 'sinatra'
gem 'sinatra-flash'
gem 'activerecord', '~> 4.2', '>= 4.2.6', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem "sqlite3", "~> 1.6.9"
gem 'thin'
gem 'shotgun'
gem 'pry'
gem 'bcrypt'
gem 'tux'

group :development, :test do 
  gem 'dotenv'
  gem 'session_secret_generator'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem "database_cleaner", "~> 1.8.5"
end
