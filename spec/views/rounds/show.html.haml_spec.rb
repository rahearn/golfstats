require 'spec_helper'

describe "rounds/show.html.haml" do

  it "renders _course partial" do
    assign :round, build_stubbed(:round)
    render
    view.should render_template(:partial => '_round')
  end

end
