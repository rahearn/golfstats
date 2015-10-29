require 'spec_helper'

describe EquitableStrokeCalculator do
  # subject do
  #   build_stubbed(:parred_hole).tap do |h|
  #     h.extend EquitableStrokeCalculator
  #   end
  # end
  subject { described_class.new handicap, 113 }
  let(:handicap) { 21.4 }
  let(:score) { 5 }
  let(:par) { 4 }

  describe "#calculate" do
    before(:each) do
      allow(subject).to receive(:max_score).and_return max
    end

    context "max is greater than score" do
      let(:max) { score + 1 }
      it { expect(subject.calculate score, par).to eq score }
    end

    context "max is less than score" do
      let(:max) { score - 1 }
      it { expect(subject.calculate score, par).to eq max }
    end
  end

  describe "#max_score" do
    context "handicap >= 40" do
      let(:handicap) { 40 }
      it { expect(subject.send :max_score, par).to eq 10 }
    end

    context "30 <= handicap < 40" do
      let(:handicap) { 30 }
      it { expect(subject.send :max_score, par).to eq 9 }
    end

    context "20 <= handicap < 30" do
      let(:handicap) { 20 }
      it { expect(subject.send :max_score, par).to eq 8 }
    end

    context "10 <= handicap < 20" do
      let(:handicap) { 10 }
      it { expect(subject.send :max_score, par).to eq 7 }
    end

    context "handicap < 10" do
      let(:handicap) { 5 }
      it { expect(subject.send :max_score, par).to eq par + 2 }
    end
  end
end
