class CoursesController < ApplicationController

  load_and_authorize_resource

  def index
  end

  def show
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

end
