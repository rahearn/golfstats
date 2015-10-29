require 'spec_helper'

describe TeeboxCreator do
  let(:round) { create :round }
  let(:scorecard) { create :scorecard, round: round }
  subject { described_class.new scorecard }

  describe "#valid?" do
    it { subject.valid?.should be true }

    context "with less than 18 holes" do
      let(:scorecard) { create :front_nine_no_back }
      it { subject.valid?.should be false }
    end
  end

  describe "#call" do
    context "with no previous teebox" do
      it "builds a teebox" do
        subject.call
        Teebox.count.should == 1
      end

      it "saves the course slope" do
        subject.call
        teebox = Teebox.where(:tees => scorecard.tees, :course_id => round.course_id).first
        teebox.slope.should == scorecard.slope
      end

      it "saves the course rating" do
        subject.call
        teebox = Teebox.where(:tees => scorecard.tees, :course_id => round.course_id).first
        teebox.rating.should == scorecard.rating
      end

      it "matches the round stats" do
        subject.call
        teebox = Teebox.where(:tees => scorecard.tees, :course_id => round.course_id).first
        teebox.holes.count.should == 18
        default_holes = teebox.holes.each
        scorecard.holes.each do |hole|
          default_hole = default_holes.next
          holes_equal? default_hole, hole
        end
      end
    end

    context "with a previous teebox" do
      let!(:teebox) { create :teebox, :course => round.course, :tees => scorecard.tees }
      let(:scorecard) { create :scorecard }

      it "updates the default holes" do
        scorecard.round = round
        subject.call
        teebox.reload
        teebox.holes.count.should == 18
        default_holes = teebox.holes.each
        scorecard.holes.each do |hole|
          default_hole = default_holes.next
          holes_equal? default_hole, hole
        end
      end
    end
  end

  def holes_equal?(actual, expected)
    actual.hole.should     == expected.hole
    actual.length.should   == expected.length
    actual.par.should      == expected.par
    actual.handicap.should == expected.handicap
  end
end
