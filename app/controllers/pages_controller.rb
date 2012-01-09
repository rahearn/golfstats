class PagesController < ApplicationController

  skip_authorization_check

  def home
    current_user.extend HomeScreenPresentation
  end

end
