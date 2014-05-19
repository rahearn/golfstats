class RoundsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_course_handicap, only: :create
  load_and_authorize_resource :course
  load_and_authorize_resource :round, through: :course, shallow: true
  before_filter :load_teebox, only: :new

  def index
    if @course.nil?
      render :all_rounds
    end
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

  def set_course_handicap
    self.extend CourseHandicap
    params[:round][:course_handicap] = (params[:round][:scorecard] || {})[:course_handicap] = handicap(current_user, params[:round][:slope])
  end

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
