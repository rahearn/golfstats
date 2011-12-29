require 'spec_helper'

describe "scorecards/show.html.haml" do

  let(:scorecard) { create :filled_in_scorecard }

  before(:each) do
    assign :scorecard, scorecard
    render
  end

  it "renders the _scorecard partial" do
    view.should render_template(:partial => '_scorecard')
  end
end
