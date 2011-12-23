require 'spec_helper'

describe "courses/new.html.haml" do

  before(:each) do
    assign :course, Course.new
    render
  end

  it "has a form for entering a new course" do
    rendered.should include '<form accept-charset="UTF-8" action="/courses" class="new_course" id="new_course" method="post">'
  end

  it "has an input box for name" do
    rendered.should include '<input id="course_name" name="course[name]" size="30" type="text" />'
  end

  it "has an input box for location" do
    rendered.should include '<input id="course_location" name="course[location]" size="30" type="text" />'
  end
end
