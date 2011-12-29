require 'spec_helper'

describe "rounds/show.html.haml" do

  let(:scorecard) { create :filled_in_scorecard }
  before(:each) do
    assign :round, build_stubbed(:round, :scorecard => scorecard)
    render
  end

  it "renders _course partial" do
    view.should render_template(:partial => '_round')
  end

  it "renders _scorecard partial" do
    view.should render_template(:partial => 'scorecards/_scorecard')
  end

end
