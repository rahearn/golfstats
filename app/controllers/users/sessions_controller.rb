module Users
  class SessionsController < ApplicationController

    prepend_before_action :require_no_authentication, :only => :new
    skip_after_action :verify_authorized

    def new
    end

    def destroy
      flash[:notice] = 'Signed out successfully.' if user_signed_in?
      sign_out current_user
      redirect_to root_path
    end

    private

    def require_no_authentication
      redirect_to root_path if user_signed_in?
    end
  end
end
