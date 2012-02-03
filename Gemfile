source 'http://rubygems.org'

gem 'rails', '3.1.3'

# database
gem 'pg'
gem 'texticle', :require => 'texticle/rails'
gem 'mongo', '1.5.2'
gem 'bson_ext', '1.5.2'
gem 'mongoid'

# authentication & authorization
gem 'devise'
gem 'omniauth-openid'
gem 'cancan'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass', '~> 0.12.alpha'
end

# presentation
gem 'jquery-rails'
gem 'haml-rails'

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
  gem 'database_cleaner'
end
