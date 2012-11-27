class PagesController < ApplicationController

  before_filter :authenticate_user!, except: :home

  skip_authorization_check

  def home
    if user_signed_in?
      redirect_to current_user.rounds.any? ? activity_path : add_round_path
    else
      extend HomeScreenPresentation
    end
  end

  def activity
    current_user.extend HomeScreenPresentation
  end

  def add_round
  end

end
