class CourseHandicapController < ApplicationController

  before_filter :authenticate_user!

  def show
    skip_authorization
    if params[:slope].present?
      @handicap = CourseHandicap.new(current_user.handicap, params[:slope]).handicap
    end
  end

end
