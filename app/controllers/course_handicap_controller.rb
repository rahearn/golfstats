class CourseHandicapController < ApplicationController

  before_filter :authenticate_user!
  skip_authorization_check

  def show
    if params[:slope].present?
      self.extend CourseHandicap
      handicap current_user, params[:slope]
    end
  end

end
