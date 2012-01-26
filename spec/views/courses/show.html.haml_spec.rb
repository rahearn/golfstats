require 'spec_helper'

describe "courses/show.html.haml" do

  let(:course) do
    build_stubbed(:course).tap { |c| c.stub(:teeboxes).and_return [] }
  end
  let(:note) { build_stubbed :course_note, :course => course }
  before(:each) do
    assign :course, course
    assign :course_note, note
    view.stub(:can?).and_return true
    view.stub(:user_signed_in?).and_return true
    render
  end

  it { rendered.should include course.name }
  it { rendered.should include course.location }
  it { rendered.should =~ /Notes.*Edit note/m }
  it { rendered.should include note.note }

end
