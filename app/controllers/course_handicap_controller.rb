class CourseHandicapController < ApplicationController

  before_filter :authenticate_user!
  skip_authorization_check

  def show
    current_user.extend HomeScreenPresentation
    if params[:slope].present?
      self.extend CourseHandicap
      @handicap = handicap current_user, params[:slope]
    end
  end

end
