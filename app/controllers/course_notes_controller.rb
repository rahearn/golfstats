class CourseNotesController < ApplicationController

  prepend_before_filter :authenticate_user!

  before_action :load_course
  before_action :new_note,  :only => [:new, :create]
  before_action :load_note, :only => [:edit, :update, :destroy]

  def new
    render layout: !request.xhr?
  end

  def create
    respond_to do |format|
      if @course_note.save
        format.html { redirect_to @course }
        format.js
      else
        format.html { render :new }
        format.js   { render :js => "alert('There was a problem saving your note. #{@course_note.errors.full_messages.join '. '}');" }
      end
    end
  end

  def edit
    render layout: !request.xhr?
  end

  def update
    respond_to do |format|
      if @course_note.update_attributes params.require(:course_note).permit(:note)
        format.html { redirect_to @course }
        format.js
      else
        format.html { render :edit }
        format.js   { render :js => "alert('There was a problem saving your note. #{@course_note.errors.full_messages.join '. '}');" }
      end
    end
  end

  def destroy
    @course_note.destroy

    redirect_to @course, :notice => 'Your note has been removed'
  end

  private

  def load_course
    @course = Course.find params[:course_id]
  end

  def new_note
    course_note_params = params.fetch(:course_note, {}).permit(:note).merge :user => current_user
    @course_note = @course.notes.build course_note_params
    authorize @course_note
  end

  def load_note
    @course_note = @course.notes.for_user current_user
    authorize @course_note
  end
  
end
