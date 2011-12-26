class ScorecardsController < ApplicationController

  load_and_authorize_resource :round
  load_resource :through => :round, :singleton => true

  def show
  end

  def new
    authorize! :new, @round
    (1..18).each do |hole|
      @scorecard.scored_holes.build(:hole => hole)
    end
  end

  def create
    authorize! :create, @round

    if @scorecard.save
      redirect_to @round
    else
      render :new
    end
  end
end
