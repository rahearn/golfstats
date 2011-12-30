require 'spec_helper'

describe DifferentialCalculator do
  let(:scorecard) { build_stubbed :scorecard, :slope => 140, :rating => 60.5 }
  subject do
    build_stubbed(:round, :slope => 110, :rating => 80.0).tap do |r|
      r.extend DifferentialCalculator
    end
  end

  describe "#calculate" do
    let(:slope)  { 110.0 }
    let(:rating) { 60.0 }
    before(:each) do
      subject.stub(:course_slope).and_return slope
      subject.stub(:course_rating).and_return rating
    end

    it "returns the differential" do
      expected = ((subject.score.to_f - rating) * 113.0) / slope
      subject.calculate.should == expected
    end
  end

  describe "#course_slope" do
    it "with no scorecard uses the default values" do
      subject.send(:course_slope).should == subject.slope.to_f
    end
    context "with a scorecard" do
      before(:each) { subject.scorecard = scorecard }

      it "uses the scorecard value" do
        subject.send(:course_slope).should == scorecard.slope.to_f
      end
    end
  end

  describe "#course_rating" do
    it "with no scorecard uses the default values" do
      subject.send(:course_rating).should == subject.rating.to_f
    end
    context "with a scorecard" do
      before(:each) { subject.scorecard = scorecard }

      it "uses the scorecard value" do
        subject.send(:course_rating).should == scorecard.rating.to_f
      end
    end
  end

end
