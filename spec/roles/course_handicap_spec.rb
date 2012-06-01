require 'spec_helper'

describe CourseHandicap do
  let(:expected) { 38 }
  let(:slope)    { 117 }
  let(:user) { build_stubbed :user }

  context "on round" do
    subject do
      build_stubbed(:round, :slope => slope).tap do |r|
        r.extend CourseHandicap
      end
    end

    describe "#handicap" do

      it { subject.handicap.should == expected }

      it "caches the value" do
        subject.handicap
        subject.user.should_not_receive :handicap
        subject.handicap
      end
    end
  end

  context "on teebox" do

    subject do
      build_stubbed(:teebox, slope: slope).tap do |t|
        t.extend CourseHandicap
      end
    end

    it { subject.handicap(user).should == expected }
  end

  context "on an object" do
    subject do
      Object.new.tap do |o|
        o.extend CourseHandicap
      end
    end

    it { subject.handicap(user, slope).should == expected }
  end
end
