class PagesController < ApplicationController

  before_filter :authenticate_user!, except: :home

  skip_authorization_check

  def home
    if user_signed_in?
      redirect_to current_user.rounds.any? ? activity_path : add_round_path
    else
      @courses = Course.joins(:rounds).order('rounds.date').limit(20).to_a.uniq
    end
  end

  def activity
    @rounds = current_user.rounds.where('differential IS NOT NULL').limit 20
    @courses = @rounds.map(&:course).uniq
  end

  def add_round
  end

end
