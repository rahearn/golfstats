module CourseNotesHelper

  def course_note_link
    options = { id: :course_note_control }
    if @course_note.present?
      link_to 'Edit note', edit_course_course_note_path(@course), options
    else
      link_to 'New note', new_course_course_note_path(@course), options
    end
  end
end
