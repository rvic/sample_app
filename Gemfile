source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'bootstrap-sass' #, '2.0.0'
gem 'bcrypt-ruby' #, '3.0.1'

group :development do
  gem 'annotate'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'win32console'
end

group :test do
  gem 'factory_girl_rails'
  gem 'cucumber-rails', require: false  #, '1.2.1', require: false
  gem 'database_cleaner'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '3.2.4'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails'

group :test do
  gem 'capybara'
end

group :production do
  gem 'pg'
end