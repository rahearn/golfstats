require 'spec_helper'

describe CourseHandicap do
  subject do
    build_stubbed(:round, :slope => slope).tap do |r|
      r.extend CourseHandicap
    end
  end

  describe "#handicap" do
    let(:expected) { 38 }
    let(:slope)    { 117 }

    it { subject.handicap.should == expected }

    it "caches the value" do
      subject.handicap
      subject.user.should_not_receive :handicap
      subject.handicap
    end
  end

end
