class CoursesController < ApplicationController

  load_and_authorize_resource
  before_filter :run_search, :only => :index

  def index
  end

  def show
    @course.extend TeeboxPresentation
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
      render :search_results
    end
  end

end
