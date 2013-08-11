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
    it { should validate_presence_of :user_id }
  end

  describe "before_validation" do
    let(:hole1) { build :hole, par: 4, length: 4, score: 4 }
    let(:hole2) { build :hole, par: 5, length: 5, score: 5 }
    subject { build :blank_scorecard, :holes => [hole1, hole2] }

    [:score, :length, :par].each do |method|
      it "sets #{method} from the holes" do
        subject.should_receive(:"#{method}=").with 9
        subject.valid?
      end
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
  end

  describe "after_save" do
    it "extends TeeboxCreator" do
      subject.should_receive(:extend).with TeeboxCreator
      subject.stub :create_teebox?, :create_teebox
      subject.run_callbacks :save
    end

    it "creates a teebox if create_teebox? is true" do
      subject.should_receive(:create_teebox?).and_return true
      subject.should_receive :create_teebox
      subject.run_callbacks :save
    end

    it "skips the create if create_teebox? is false" do
      subject.should_receive(:create_teebox?).and_return false
      subject.should_not_receive :create_teebox
      subject.run_callbacks :save
    end
  end
end
