module Users
  class SessionsController < ApplicationController

    prepend_before_filter :require_no_authentication, :only => :new
    skip_authorization_check

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
