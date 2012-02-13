class PagesController < ApplicationController

  before_filter :authenticate_user!
  skip_authorization_check

  def home
    if user_signed_in?
      current_user.extend HomeScreenPresentation
      render :activity
    end
  end

end
