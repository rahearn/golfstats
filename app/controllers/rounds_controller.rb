class RoundsController < ApplicationController

  load_and_authorize_resource :course
  load_and_authorize_resource :round, through: :course, shallow: true
  before_filter :load_teebox, only: :new
  cache_sweeper :round_sweeper, only: :update

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
      @round.garmin_file = nil
      render :new
    end
  end

  def edit
  end

  def update
    if @round.update_attributes params[:round]
      redirect_to @round
    else
      render :edit
    end
  end

  private

  def load_teebox
    if params[:tees].present?
      @teebox = Teebox.where(
        tees:      params[:tees].downcase,
        course_id: @course.id
      ).first
      unless @teebox.nil?
        @round.slope  = @teebox.slope
        @round.rating = @teebox.rating
        @round.tees   = @teebox.tees.humanize
      end
    end
  end
end
