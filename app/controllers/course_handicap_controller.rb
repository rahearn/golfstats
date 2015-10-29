class CourseHandicapController < ApplicationController

  before_filter :authenticate_user!
  skip_authorization_check

  def show
    if params[:slope].present?
      @handicap = CourseHandicap.new(current_user.handicap, params[:slope]).handicap
    end
  end

end
