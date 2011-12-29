require 'spec_helper'

describe "scorecards/new.html.haml" do

  let(:round) { create :round }
  before(:each) do
    assign :round, round
    assign :scorecard, Scorecard.new(:round => round)
    render
  end

  it "renders the _form partial" do
    view.should render_template(:partial => '_form')
  end
end
