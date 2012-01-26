require 'spec_helper'

describe "course_notes/_form.html.haml" do

  let(:course) { create :course }
  before(:each) do
    assign :course, course
    assign :course_note, CourseNote.new
    render
  end

  it "has a form for entering a new note" do
    rendered.should include(
      %|<form accept-charset="UTF-8" action="/courses/#{course.id}/note" class="new_course_note" id="new_course_note" method="post">|
    )
  end

  it "has a textarea for the note" do
    rendered.should include '<textarea cols="40" id="course_note_note" name="course_note[note]" rows="4">'
  end

end
