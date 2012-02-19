require 'spec_helper'

describe "courses/index" do

  before(:each) do
    view.stub(:can?).and_return true
  end

  it "renders _course partial for each course" do
    assign :courses, [build_stubbed(:course), build_stubbed(:course)]
    render
    view.should render_template(:partial => '_course', :count => 2)
  end

end
