require 'spec_helper'

describe "courses/show.html.haml" do

  let(:course) { build_stubbed :course }
  before(:each) do
    assign :course, course
    view.stub(:can?).and_return true
    render
  end

  it { rendered.should include course.name }
  it { rendered.should include course.location }

end
