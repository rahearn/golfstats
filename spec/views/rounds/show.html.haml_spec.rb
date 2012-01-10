require 'spec_helper'

describe "rounds/show.html.haml" do

  let(:scorecard) { create :scorecard }
  let(:notes)     { "solid putting" }
  let(:round)     { build_stubbed :round, :scorecard => scorecard, :notes => notes }
  before(:each) do
    view.stub(:can?).and_return true
    assign :round, round
    render
  end

  it "displays the course name" do
    rendered.should include round.course_name
  end

  it "displays the round date" do
    rendered.should include round.date.to_s
  end

  it "displays the round notes" do
    rendered.should include notes
  end

  it "renders _scorecard partial" do
    view.should render_template(:partial => 'scorecards/_scorecard')
  end

  context "without a scorecard" do
    let(:round) { build_stubbed :round }

    it "displays the score" do
      rendered.should include "<em>Score:</em>\n#{round.score}"
    end
  end

end
