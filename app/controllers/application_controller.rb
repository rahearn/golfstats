class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    Rails.logger.warn "Pundit::NotAuthorizedError: #{exception.message}"
    if user_signed_in?
      redirect_to root_path, :alert => exception.message
    else
      authenticate_user!
    end
  end
end
