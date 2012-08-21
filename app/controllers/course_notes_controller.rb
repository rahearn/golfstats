class CourseNotesController < ApplicationController

  prepend_before_filter :authenticate_user!

  load_and_authorize_resource :course
  before_filter :new_note,  :only => [:new, :create]
  before_filter :load_note, :only => [:edit, :update, :destroy]
  authorize_resource

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
      if @course_note.update_attributes params[:course_note]
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

  def new_note
    notes_params = (params[:course_note] || {}).merge :user => current_user
    @course_note = @course.notes.build notes_params
  end

  def load_note
    @course_note = @course.notes.for_user current_user
  end
end
