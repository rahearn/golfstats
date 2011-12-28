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
    it { should validate_presence_of :differential }
    it { should have_readonly_attribute :user }
    it { should have_readonly_attribute :course }
    it { should have_readonly_attribute :date }
    it { should have_readonly_attribute :score }
    it { should have_readonly_attribute :differential }
  end

  describe "before_validation" do
    subject { build :round }

    it "should set differential to the score" do
      subject.valid?
      subject.differential.should == subject.score
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
