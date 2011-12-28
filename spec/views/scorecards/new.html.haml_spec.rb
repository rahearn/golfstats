require 'spec_helper'

describe "scorecards/new.html.haml" do

  let(:round) { create :round }
  before(:each) do
    assign :round, round
    assign :scorecard, Scorecard.new(:round => round)
    render
  end

  it "has a form for entering a new scorecard" do
    rendered.should include(
      %|<form accept-charset="UTF-8" action="/rounds/#{round.id}/scorecard" class="new_scorecard" id="new_scorecard" method="post"|
    )
  end

end
