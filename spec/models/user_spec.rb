require 'spec_helper'

describe User do

  describe "relations" do
    it { should have_many(:rounds).dependent :destroy }
    it { should have_many(:course_notes).dependent :destroy }
  end

  describe "validations" do
    it { should validate_presence_of :openid_uid }
    it { should validate_presence_of :openid_provider }
    it { should validate_format_of(:email).with 'example@mail.com' }
    it { should validate_format_of(:email).not_with 'missing_tld@email' }
    it { should allow_value('male').for :gender }
    it { should allow_value('female').for :gender }
    it { should_not allow_value('other').for :gender }
    it { should validate_numericality_of :handicap }
    it { should allow_value(36.4).for :handicap }
    it { should_not allow_value(36.5).for :handicap }
    context "require db users" do
      before(:each) { create :full_user }
      it { should validate_uniqueness_of :email }
      it { should validate_uniqueness_of(:openid_uid).scoped_to :openid_provider }
    end
  end

  describe "security" do
    it { should_not allow_mass_assignment_of :openid_uid }
  end

  describe "#maximum_handicap" do
    context "for a male" do
      subject { build_stubbed :user }

      it { subject.send(:maximum_handicap).should == 36.4 }
    end

    context "for a female" do
      subject { build_stubbed :female_user }

      it { subject.send(:maximum_handicap).should == 40.4 }
    end
  end
end
