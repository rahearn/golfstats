require 'spec_helper'

describe Scorecard do
  include Mongoid::Matchers

  describe "relations" do
    it { should embed_many :holes }
  end

  describe "validations" do
    it { should validate_presence_of :tees }
    it { should validate_presence_of :length }
    it { should validate_presence_of :par }
    it { should validate_presence_of :score }
  end

  describe "#round" do
    let(:round) { create :round }
    subject { build_stubbed :scorecard, :round_id => round.id }

    it "retrieves the round object" do
      subject.round.should == round
    end
  end

  describe "#round=" do
    let(:round) { create :round }

    it "assigns the correct round_id" do
      subject.round = round
      subject.round_id.should == round.id
    end

    describe "updates the teebox" do
      context "with only 9 holes" do
        subject { build_stubbed :blank_scorecard }
        before(:each) do
          (1..9).each do |h|
            subject.holes.build attributes_for(:hole, :hole => h)
          end
        end

        it "does not build a teebox" do
          subject.round = round
          Teebox.count.should == 0
        end
      end

      context "with 18 holes" do
        subject { build_stubbed :scorecard }
        context "and no teebox" do
          it "builds a teebox" do
            subject.round = round
            Teebox.count.should == 1
          end
          it "matches the round stats" do
            subject.round = round
            teebox = Teebox.where(:tees => subject.tees, :course_id => round.course_id).first
            teebox.holes.count.should == 18
            default_holes = teebox.holes.each
            subject.holes.each do |hole|
              default_hole = default_holes.next
              holes_equal? default_hole, hole
            end
          end
        end
        context "and a previous teebox" do
          let(:teebox) { create :teebox, :course => round.course, :tees => subject.tees }
          before(:each) do
            (1..18).each do |hole|
              teebox.holes.create attributes_for(:teebox_hole, :hole => hole, :length => 100)
            end
          end

          it "updates the default holes" do
            subject.round = round
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

    end

  end

  def holes_equal?(actual, expected)
    actual.hole.should     == expected.hole
    actual.length.should   == expected.length
    actual.par.should      == expected.par
    actual.handicap.should == expected.handicap
  end
end
