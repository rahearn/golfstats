require 'spec_helper'

describe Scorecard do
  include Mongoid::Matchers

  describe "relations" do
    it { should embed_many :scored_holes }
  end

  describe "validations" do
    it { should validate_presence_of :tee }
    it { should validate_presence_of :length }
    it { should validate_presence_of :par }
    it { should validate_presence_of :score }
  end
end
