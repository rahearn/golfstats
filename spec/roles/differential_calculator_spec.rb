require 'spec_helper'

describe DifferentialCalculator do
  let(:scorecard) { build :scorecard, :slope => 140 }
  let(:slope)     { 110 }
  let(:rating)    { 80.0 }
  subject do
    build_stubbed(:round, :slope => slope, :rating => rating).tap do |r|
      r.extend DifferentialCalculator
    end
  end

  describe "#calculate" do
    it "returns the differential" do
      expected = ((subject.score.to_f - rating) * 113.0) / slope
      expect(subject.calculate.to_f).to eq expected
    end

    it "returns nil if from a partial round" do
      subject.stub(:partial_round?).and_return true
      subject.calculate.should be_nil
    end
  end

  describe "#partial_round?" do
    it "with no scorecard is false" do
      subject.send(:partial_round?).should be_false
    end
    it "with a full scorecard is false" do
      subject.scorecard = scorecard
      subject.send(:partial_round?).should be_false
    end
    it "with a partial scorecard is true" do
      subject.scorecard = build :front_nine_with_back
      subject.send(:partial_round?).should be_true
    end
  end

end
