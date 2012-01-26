require 'spec_helper'

describe "course_notes/new.html.haml" do

  before(:each) do
    assign :course, build_stubbed(:course)
    assign :course_note, CourseNote.new
    render
  end

  it { view.should render_template(:partial => "_form") }

  it { rendered.should_not include 'Delete note' }
end
