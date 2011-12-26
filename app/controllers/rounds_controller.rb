class RoundsController < ApplicationController

  load_and_authorize_resource :course
  load_and_authorize_resource :round, :through => :course, :shallow => true

  def index
  end

  def show
  end

  def new
  end

  def create
    if @round.save
      redirect_to @round
    else
      render :new
    end
  end

end
