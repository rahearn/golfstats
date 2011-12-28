require 'spec_helper'

describe Hole do
  include Mongoid::Matchers

  describe "relations" do
    it { should be_embedded_in :scorecard }
  end

  describe "validations" do
    it { should validate_presence_of :hole }
    it { should validate_presence_of :par }
    it { should validate_presence_of :score }
  end

end
