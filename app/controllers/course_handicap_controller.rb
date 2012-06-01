class CourseHandicapController < ApplicationController

  before_filter :authenticate_user!
  skip_authorization_check

  def show
    self.extend CourseHandicap
    current_user.extend HomeScreenPresentation
    @handicap = handicap current_user, params[:slope]
  end

end
