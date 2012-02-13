class PagesController < ApplicationController

  skip_authorization_check

  def home
    if user_signed_in?
      current_user.extend HomeScreenPresentation
      render :activity
    else
      extend HomeScreenPresentation
    end
  end

end
