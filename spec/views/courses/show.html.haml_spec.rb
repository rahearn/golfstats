require 'spec_helper'

describe "courses/show.html.haml" do

  let(:course) do
    build_stubbed(:course).tap { |c| c.stub(:teeboxes).and_return [] }
  end
  before(:each) do
    assign :course, course
    view.stub(:can?).and_return true
    render
  end

  it { rendered.should include course.name }
  it { rendered.should include course.location }

end
