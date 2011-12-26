class ApplicationController < ActionController::Base
  protect_from_forgery

  check_authorization

  rescue_from CanCan::AccessDenied do |ex|
    Rails.logger.warn "CanCan::AccessDenied: #{ex.message}"
    if user_signed_in?
      redirect_to root_path, :alert => ex.message
    else
      authenticate_user!
    end
  end
end
