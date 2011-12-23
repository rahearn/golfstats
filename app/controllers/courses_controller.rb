class CoursesController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find params[:id]
  end

  def new
    @course = Course.new params[:course]
  end

  def create
    @course = Course.new params[:course]

    if @course.save
      redirect_to @course
    else
      render :new
    end
  end

end
