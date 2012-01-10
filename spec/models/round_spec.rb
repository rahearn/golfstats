require 'spec_helper'

describe Round do

  describe "relations" do
    it { should belong_to :user }
    it { should belong_to :course }
  end

  describe "validations" do
    it { should validate_presence_of :user }
    it { should validate_presence_of :course }
    it { should validate_presence_of :date }
    it { should validate_presence_of :score }
    it { should validate_presence_of :slope }
    it { should validate_presence_of :rating }
    it { should have_readonly_attribute :user }
    it { should have_readonly_attribute :course }
    it { should have_readonly_attribute :date }
    it { should have_readonly_attribute :score }
    it { should have_readonly_attribute :differential }
    it { should validate_numericality_of :slope }
    it { should validate_numericality_of :rating }
  end

  describe "before_create" do
    subject { build :round }

    it "should extend DifferentialCalculator" do
      subject.should_receive(:extend).with DifferentialCalculator
      subject.stub :calculate
      subject.run_callbacks :create
    end

    it "assigns the calculated value to differential" do
      subject.should_receive(:calculate).and_return 35.0
      subject.run_callbacks :create
      subject.differential.should == 35.0
    end
  end

  describe "after_create" do
    subject { build :round }

    it "should extend user with handicap calculator" do
      subject.user.should_receive(:extend).with HandicapCalculator
      subject.user.stub :update_handicap!
      subject.run_callbacks :create
    end

    it "should call update_handicap!" do
      subject.user.should_receive :update_handicap!
      subject.run_callbacks :create
    end
  end

  describe "#scorecard" do
    let(:scorecard) { create :scorecard }
    subject { build_stubbed :round, :scorecard_id => scorecard.id }

    it "retrieves the scorecard object" do
      subject.scorecard.should == scorecard
    end
  end

  describe "#scorecard=" do
    let(:scorecard) { create :scorecard }

    it "assigns the correct scorecard_id" do
      subject.scorecard = scorecard
      subject.scorecard_id.should == scorecard.id.to_s
    end
  end
end
