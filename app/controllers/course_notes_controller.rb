class CourseNotesController < ApplicationController

  prepend_before_filter :authenticate_user!

  load_and_authorize_resource :course
  before_filter :new_note,  :only => [:new, :create]
  before_filter :load_note, :only => [:edit, :update, :destroy]
  authorize_resource

  def new
  end

  def create
    if @course_note.save
      redirect_to @course
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course_note.update_attributes params[:course_note]
      redirect_to @course
    else
      render :edit
    end
  end

  def destroy
    @course_note.destroy

    redirect_to @course, :notice => 'Your note has been removed'
  end

  private

  def new_note
    notes_params = (params[:course_note] || {}).merge :user => current_user
    @course_note = @course.notes.build notes_params
  end

  def load_note
    @course_note = @course.notes.for_user current_user
  end
end
