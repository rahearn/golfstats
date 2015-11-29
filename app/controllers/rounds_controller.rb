class RoundsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_course_handicap, only: :create
  before_action :load_course, only: [:index, :new, :create]
  before_action :load_round, only: [:show, :edit, :update]

  def index
    @rounds = policy_scope Round
    if @course.nil?
      render :all_rounds
    else
      @rounds.where! course: @course
    end
  end

  def show
  end

  def new
    @round = @course.rounds.build user: current_user
    authorize @round

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

  def create
    @round = @course.rounds.build round_params.merge(user: current_user)
    authorize @round
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
    if @round.update_attributes round_params
      redirect_to @round
    else
      render :edit
    end
  end

  private

  def load_course
    @course = Course.find_by id: params[:course_id]
  end

  def load_round
    @round = Round.find params[:id]
    authorize @round
  end

  def round_params
    # TODO tighten this up
    params.require(:round).permit!
  end

  def set_course_handicap
    handicap = CourseHandicap.new(current_user.handicap, params[:round][:slope]).handicap
    params[:round][:course_handicap] = (params[:round][:scorecard] || {})[:course_handicap] = handicap
  end
end
