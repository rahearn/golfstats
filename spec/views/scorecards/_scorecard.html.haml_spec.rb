require 'spec_helper'

describe "scorecards/_scorecard" do

  let(:scorecard) { create :scorecard }
  let(:holes)     { scorecard.holes }
  before(:each) do
    render :partial => "scorecard", :locals => {:scorecard => scorecard}
  end

  it "displays the score for each hole" do
    rendered.should include(
      holes.inject("<div class='unit size2of21 label'>Score</div>\n") do |row, hole|
        row << "<div class='unit size1of21'>#{hole.score}</div>\n"
      end + "<div class='unit size1of21 lastUnit total'>#{scorecard.score}</div>"
    )
  end

  it "displays the length for each hole" do
    rendered.should include(
      holes.inject("<div class='unit size2of21 label'>Yardage</div>\n") do |row, hole|
        row << "<div class='unit size1of21'>#{hole.length}</div>\n"
      end + "<div class='unit size1of21 lastUnit total'>#{scorecard.length}</div>"
    )
  end

  it "displays the par for each hole" do
    rendered.should include(
      holes.inject("<div class='unit size2of21 label'>Par</div>\n") do |row, hole|
        row << "<div class='unit size1of21'>#{hole.par}</div>\n"
      end + "<div class='unit size1of21 lastUnit total'>#{scorecard.par}</div>"
    )
  end

  it "displays the handicap for each hole" do
    rendered.should include(
      holes.inject("<div class='unit size2of21 label'>Handicap</div>\n") do |row, hole|
        row << "<div class='unit size1of21'>#{hole.handicap}</div>\n"
      end
    )
  end
end
