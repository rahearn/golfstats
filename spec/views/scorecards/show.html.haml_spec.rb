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

  it "displays the score for each hole" do
    rendered.should include(
      holes.inject("<td>Score</td>\n") do |row, hole|
        row << "<td>#{hole.score}</td>\n"
      end + "<td>#{scorecard.score}</td>"
    )
  end

  it "displays the length for each hole" do
    rendered.should include(
      holes.inject("<td>Yardage</td>\n") do |row, hole|
        row << "<td>#{hole.length}</td>\n"
      end + "<td>#{scorecard.length}</td>"
    )
  end

  it "displays the par for each hole" do
    rendered.should include(
      holes.inject("<td>Par</td>\n") do |row, hole|
        row << "<td>#{hole.par}</td>\n"
      end + "<td>#{scorecard.par}</td>"
    )
  end

  it "displays the handicap for each hole" do
    rendered.should include(
      holes.inject("<td>Handicap</td>\n") do |row, hole|
        row << "<td>#{hole.handicap}</td>\n"
      end + "<td>&nbsp;</td>"
    )
  end
end
