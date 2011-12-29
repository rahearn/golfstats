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
    context "when holed is a teebox" do
      subject { build :teebox_hole }
      it { subject.should be_valid }
    end
  end

end
