require 'spec_helper'

describe "scorecards/_scorecard" do

  let(:scorecard) { create :scorecard }
  let(:holes)     { scorecard.holes }
  before(:each) do
    render :partial => "scorecard", :locals => {:scorecard => scorecard}
  end

  it "displays the score for each hole" do
    rendered.should include(
      holes.inject("<div class='hole label'>Score</div>\n") do |row, hole|
        row << "<div class='hole'>#{hole.score}</div>\n"
      end + "<div class='hole total'>#{scorecard.score}</div>"
    )
  end

  it "displays the length for each hole" do
    rendered.should include(
      holes.inject("<div class='hole label'>Yardage</div>\n") do |row, hole|
        row << "<div class='hole'>#{hole.length}</div>\n"
      end + "<div class='hole total'>#{scorecard.length}</div>"
    )
  end

  it "displays the par for each hole" do
    rendered.should include(
      holes.inject("<div class='hole label'>Par</div>\n") do |row, hole|
        row << "<div class='hole'>#{hole.par}</div>\n"
      end + "<div class='hole total'>#{scorecard.par}</div>"
    )
  end

  it "displays the handicap for each hole" do
    rendered.should include(
      holes.inject("<div class='hole label'>Handicap</div>\n") do |row, hole|
        row << "<div class='hole'>#{hole.handicap}</div>\n"
      end
    )
  end
end
