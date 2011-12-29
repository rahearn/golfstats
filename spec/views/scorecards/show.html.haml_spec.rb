require 'spec_helper'

describe "scorecards/show.html.haml" do

  let(:scorecard) { create :scorecard, :holes => holes }
  let(:holes) do
    18.times.map do |index|
      build :hole
    end
  end

  before(:each) do
    assign :scorecard, scorecard
    render
  end

  it "renders the _scorecard partial" do
    view.should render_template(:partial => '_scorecard')
  end
end
