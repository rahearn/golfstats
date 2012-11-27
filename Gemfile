source 'http://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.7'
gem 'thin'

group :production do
  gem 'memcachier'
  gem 'dalli'
end

# database
gem 'pg'
gem 'texticle', :require => 'texticle/rails'
gem 'mongo', '1.6.4'
gem 'bson_ext', '1.6.4'
gem 'mongoid'

# authentication & authorization
gem 'devise'
gem 'omniauth-openid'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'cancan'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
  gem 'jquery-rails'
  gem 'ggs-rails'
end

# presentation
gem 'haml-rails'
gem 'turbolinks', '0.5.1' # bug in 0.5.2 prevents use in devel mode

# misc
gem 'ruby_flipper'
gem 'nokogiri'
gem 'newrelic_rpm'

group :development do
  gem 'heroku_san'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'mongoid-rspec'
  gem 'factory_girl_rails'
  gem 'factory_girl'
  gem 'database_cleaner'
end
