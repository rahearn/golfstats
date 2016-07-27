RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, :type => :controller
end

Devise.stretches = 1
