class RoundsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @rounds = current_user.rounds
  end

  def show
    @round = Round.find params[:id]
    if @round.user != current_user
      render :file => Rails.root.join('public', '404.html'), :status => 404, :layout => false and return
    end
  end

  def new
    @round = Round.new params[:round]
  end

  def create
    @round = Round.new params[:round].merge(:user => current_user)

    if @round.save
      redirect_to @round
    else
      render :new
    end
  end

end
