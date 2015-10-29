class CoursesController < ApplicationController

  before_action :run_search, :only => :index

  def index
    @courses = policy_scope(Course).order :name
  end

  def show
    @course = Course.find params[:id]
    authorize @course
    if user_signed_in?
      @handicap_caluculator = CourseHandicap.new current_user.handicap, nil
      @course_note = @course.notes.for_user current_user
    end
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    @course = Course.new course_params
    authorize @course
    if @course.save
      redirect_to @course
    else
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit :name, :location
  end

  def run_search
    if params[:q].present?
      @courses = policy_scope(Course).search params[:q]
      if @courses.any?
        render :search_results
      else
        redirect_to new_course_path, notice: %|No courses found for "#{params[:q]}".|
      end
    end
  end

end
