class PagesController < ApplicationController

  before_filter :authenticate_user!
  skip_authorization_check

  def home
    current_user.extend HomeScreenPresentation
  end

end
