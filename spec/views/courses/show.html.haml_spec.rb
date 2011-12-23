require 'spec_helper'

describe "courses/show.html.haml" do

  it "renders _course partial" do
    assign :course, build_stubbed(:course)
    render
    view.should render_template(:partial => '_course')
  end
end
