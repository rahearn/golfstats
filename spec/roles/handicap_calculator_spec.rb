require 'spec_helper'

describe HandicapCalculator do
  let(:user)   { build_stubbed :user }
  let(:course) { build_stubbed :course }
  let(:rounds) do
    [
      build_stubbed(:round, :course => course, :user => user, :differential => 10.323),
      build_stubbed(:round, :course => course, :user => user, :differential => 14.212),
      build_stubbed(:round, :course => course, :user => user, :differential => 12.321)
    ]
  end
  subject do
    user.tap do |u|
      u.extend HandicapCalculator
    end
  end

  describe "#update_handicap!" do
    it "sets the handicap" do
      subject.should_receive(:calculate).and_return 11.1
      subject.should_receive(:handicap=).with 11.1
      subject.stub :save
      subject.update_handicap!
    end

    it "saves the model" do
      subject.should_receive :save
      subject.update_handicap!
    end
  end

  describe "#calculate" do
    context "with useable rounds" do
      let(:expected) { 11.7 }
      before(:each) { subject.stub(:sorted_rounds).and_return rounds }

      it "calculates the handicap" do
        subject.calculate.should == expected
      end
    end

    it "returns nil when no rounds" do
      subject.calculate.should be_nil
    end
  end
end
