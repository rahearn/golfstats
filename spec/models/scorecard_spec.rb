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

  describe "#round" do
    let(:round) { create :round }
    subject { build_stubbed :scorecard, :round_id => round.id }

    it "retrieves the round object" do
      subject.round.should == round
    end
  end

  describe "#round=" do
    let(:round) { create :round }

    it "assigns the correct round_id" do
      subject.round = round
      subject.round_id.should == round.id
    end
  end
end
