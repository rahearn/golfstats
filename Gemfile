source 'http://rubygems.org'

ruby '2.2.3'
gem 'rails', '4.2.4'
gem 'unicorn', '~> 4.8'

# database
gem 'pg'
gem 'textacular', '~> 3.0', require: 'textacular/rails'
gem 'mongo', '2.1.2'
gem 'mongoid', '~> 5.0'

# authentication & authorization
gem 'devise'
gem 'omniauth-openid'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'pundit', '~> 1.0'

# assets
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'compass-rails'
gem 'jquery-rails'
gem 'ggs-rails', '~> 1.1'

# presentation
gem 'haml-rails'
gem 'turbolinks'

# misc
gem 'nokogiri'
gem 'newrelic_rpm'

group :development do
  gem 'heroku_san'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.3'
end

group :test do
  gem 'rspec-its', '~> 1.0'
  gem 'factory_girl_rails'
  gem 'tork'
  gem 'rb-fsevent'
  gem 'shoulda-matchers'
  gem 'mongoid-rspec', '~> 3.0'
  gem 'database_cleaner'
end

group :production do
  gem 'rails_12factor'
end
