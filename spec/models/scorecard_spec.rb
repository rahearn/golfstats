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
    it { should validate_presence_of :slope }
    it { should validate_presence_of :rating }
    it { should validate_numericality_of(:slope).
      greater_than_or_equal_to(55).less_than_or_equal_to 155 }
    it { should validate_numericality_of :rating }
  end

  describe "before_validation" do
    let(:hole) { build :hole }
    subject { build :blank_scorecard, :holes => [hole] }

    it "extends EquitableStrokeCalculator on the hole" do
      hole.should_receive(:extend).with EquitableStrokeCalculator
      hole.stub :calculate
      subject.valid?
    end

    it "assigns the hole score to the value calculated" do
      hole.should_receive(:calculate).and_return 15
      hole.should_receive(:score=).with 15
      subject.valid?
    end
  end

  describe "#round" do
    let(:round) { create :round }
    subject { build :scorecard, :round_id => round.id }

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

    it "extends TeeboxCreator" do
      subject.should_receive(:extend).with TeeboxCreator
      subject.stub :create_teebox?, :create_teebox
      subject.round = round
    end

    it "creates a teebox if create_teebox? is true" do
      subject.should_receive(:create_teebox?).and_return true
      subject.should_receive :create_teebox
      subject.round = round
    end

    it "skips the create if create_teebox? is false" do
      subject.should_receive(:create_teebox?).and_return false
      subject.should_not_receive :create_teebox
      subject.round = round
    end
  end

end
