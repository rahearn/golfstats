require 'spec_helper'

describe EquitableStrokeCalculator do
  subject do
    build_stubbed(:parred_hole).tap do |h|
      h.extend EquitableStrokeCalculator
    end
  end

  describe "#calculate" do
    before(:each) do
      subject.stub(:max_score).and_return max
    end

    context "max is greater than score" do
      let(:max) { subject.score + 1 }
      it { subject.calculate.should == subject.score }
    end

    context "max is less than score" do
      let(:max) { subject.score - 1 }
      it { subject.calculate.should == max }
    end
  end

  describe "#max_score" do
    before(:each) do
      subject.stub(:holed).and_return double(user: double(handicap: handicap), slope: 113)
    end

    context "handicap >= 40" do
      let(:handicap) { 40 }
      it { subject.send(:max_score).should == 10 }
    end

    context "30 <= handicap < 40" do
      let(:handicap) { 30 }
      it { subject.send(:max_score).should == 9 }
    end

    context "20 <= handicap < 30" do
      let(:handicap) { 20 }
      it { subject.send(:max_score).should == 8 }
    end

    context "10 <= handicap < 20" do
      let(:handicap) { 10 }
      it { subject.send(:max_score).should == 7 }
    end

    context "handicap < 10" do
      let(:handicap) { 5 }
      it { subject.send(:max_score).should == subject.par + 2 }
    end
  end
end
