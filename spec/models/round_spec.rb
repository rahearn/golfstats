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
    it { should validate_numericality_of :slope }
    it { should validate_numericality_of :rating }
  end

  describe "before_save" do
    subject { build :round }

    it "should extend DifferentialCalculator" do
      subject.should_receive(:extend).with DifferentialCalculator
      subject.stub :calculate
      subject.run_callbacks :save
    end

    it "assigns the calculated value to differential" do
      subject.should_receive(:calculate).and_return 35.0
      subject.run_callbacks :save
      subject.differential.should == 35.0
    end
  end

  describe "after_save" do
    subject { build :round }

    it "should extend user with handicap calculator" do
      subject.user.should_receive(:extend).with HandicapCalculator
      subject.user.stub :update_handicap!
      subject.run_callbacks :save
    end

    it "should call update_handicap!" do
      subject.user.should_receive :update_handicap!
      subject.run_callbacks :save
    end
  end

  describe "after_destroy" do
    subject { build :round }

    it "should call scorecard.destroy" do
      subject.stub(:scorecard).and_return(mock_model(Scorecard).tap do |sc|
        sc.should_receive :destroy
      end)
      subject.run_callbacks :destroy
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

  describe "#scorecard?" do
    context "for new round" do
      specify { subject.scorecard?.should be_true }
    end

    context "for saved round with scorecard" do
      subject { create :round, scorecard: create(:scorecard) }

      specify { subject.scorecard?.should be_true }
    end

    context "for saved round with no scorecard" do
      subject { create :round }

      specify { subject.scorecard?.should be_false }
    end
  end
end
