class PagesController < ApplicationController

  skip_authorization_check

  def home
    if user_signed_in?
      current_user.extend HomeScreenPresentation
      render :user_home
    else
      extend HomeScreenPresentation
      render :guest_home
    end
  end

end
