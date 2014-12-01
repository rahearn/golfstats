source 'http://rubygems.org'

ruby '2.1.5'
gem 'rails', '3.2.21'
gem 'unicorn', '~> 4.8'

# database
gem 'pg'
gem 'textacular', '~> 3.0', require: 'textacular/rails'
gem 'mongo', '1.9.2'
gem 'bson_ext', '1.9.2'
gem 'mongoid', '~> 3.1'

# authentication & authorization
gem 'devise'
gem 'omniauth-openid'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'cancan', '~> 1.6', '!= 1.6.10'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
  gem 'jquery-rails'
  gem 'ggs-rails', '~> 1.1'
end

# presentation
gem 'haml-rails'
gem 'turbolinks'

# misc
gem 'ruby_flipper'
gem 'nokogiri'
gem 'newrelic_rpm'

group :development do
  gem 'heroku_san'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.99'
end

group :test do
  gem 'rspec-its', '~> 1.0'
  gem 'factory_girl_rails'
  gem 'tork'
  gem 'rb-fsevent'
  gem 'shoulda-matchers'
  gem 'mongoid-rspec', '~> 1.9'
  gem 'database_cleaner'
end
