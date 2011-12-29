require 'spec_helper'

describe Hole do
  include Mongoid::Matchers

  describe "relations" do
    it { should be_embedded_in :holed }
  end

  describe "validations" do
    it { should validate_presence_of :hole }
    it { should validate_presence_of :par }
    it { should validate_presence_of :score }
    it { should validate_uniqueness_of :hole }
    it { should validate_uniqueness_of :handicap }
    it { should validate_numericality_of(:hole).less_than_or_equal_to 18 }
    it { should validate_numericality_of(:handicap).less_than_or_equal_to 18 }
    context "when holed is a teebox" do
      subject { build :teebox_hole }
      it { subject.should be_valid }
    end
  end

end
