source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'thin'

group :production do
  gem 'memcachier'
  gem 'dalli'
end

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
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
end

# presentation
gem 'jquery-rails'
gem 'haml-rails'

# misc
gem 'ruby_flipper', :git => 'git://github.com/rahearn/ruby_flipper.git', :branch => 'topic/dynamic_arguments'
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
  gem 'factory_girl', '2.5.0'
  gem 'database_cleaner'
end
