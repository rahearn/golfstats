require 'spec_helper'

describe TeeboxCreator do
  let(:round) { create :round }
  subject do
    create(:scorecard, round: round).tap do |sc|
      sc.extend TeeboxCreator
    end
  end

  describe "#create_teebox?" do
    it { subject.create_teebox?.should be_true }

    context "with less than 18 holes" do
      subject do
        create(:front_nine_no_back).tap do |sc|
          sc.extend TeeboxCreator
        end
      end

      it { subject.create_teebox?.should be_false }
    end
  end

  describe "#create_teebox" do
    context "with no previous teebox" do
      it "builds a teebox" do
        subject.create_teebox
        Teebox.count.should == 1
      end

      it "saves the course slope" do
        subject.create_teebox
        teebox = Teebox.where(:tees => subject.tees, :course_id => round.course_id).first
        teebox.slope.should == subject.slope
      end

      it "saves the course rating" do
        subject.create_teebox
        teebox = Teebox.where(:tees => subject.tees, :course_id => round.course_id).first
        teebox.rating.should == subject.rating
      end

      it "matches the round stats" do
        subject.create_teebox
        teebox = Teebox.where(:tees => subject.tees, :course_id => round.course_id).first
        teebox.holes.count.should == 18
        default_holes = teebox.holes.each
        subject.holes.each do |hole|
          default_hole = default_holes.next
          holes_equal? default_hole, hole
        end
      end
    end

    context "with a previous teebox" do
      let!(:teebox) { create :teebox, :course => round.course, :tees => subject.tees }
      subject do
        create(:scorecard).tap do |sc|
          sc.extend TeeboxCreator
        end
      end

      it "updates the default holes" do
        subject.round = round
        subject.create_teebox
        teebox.reload
        teebox.holes.count.should == 18
        default_holes = teebox.holes.each
        subject.holes.each do |hole|
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
