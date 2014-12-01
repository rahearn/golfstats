class CoursesController < ApplicationController

  load_and_authorize_resource
  before_filter :run_search, :only => :index

  def index
    @courses = @courses.order :name
  end

  def show
    @course.extend TeeboxPresentation
    @course_note = @course.notes.for_user(current_user) if user_signed_in?
  end

  def new
  end

  def create
    if @course.save
      redirect_to @course
    else
      render :new
    end
  end

  private

  def run_search
    if params[:q].present?
      @courses = @courses.search params[:q]
      render :search_results if @courses.any?
      redirect_to new_course_path, notice: %|No courses found for "#{params[:q]}".| if @courses.empty?
    end
  end

end
