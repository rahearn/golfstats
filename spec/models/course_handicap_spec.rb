require 'spec_helper'

describe CourseHandicap do
  let(:expected) { 38 }
  let(:slope)    { 117 }
  let(:user) { build_stubbed :user }

  describe '#handicap' do
    subject { described_class.new user.handicap, slope }
    specify { expect(subject.handicap).to eq expected }
  end
end
