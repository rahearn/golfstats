require 'spec_helper'

describe User do

  describe "relations" do
    it { should have_many(:rounds).dependent :destroy }
    it { should have_many(:course_notes).dependent :destroy }
  end

  describe "validations" do
    it { should validate_presence_of :openid_uid }
    it { should validate_presence_of :openid_provider }
    it { should allow_value('example@mail.com').for :email }
    it { should_not allow_value('missing_hostname').for :email }
    it { should allow_value('male').for :gender }
    it { should allow_value('female').for :gender }
    it { should_not allow_value('other').for :gender }
    it { should allow_value(36.4).for :handicap }
    it { should_not allow_value(36.5).for :handicap }
    context "require db users" do
      before(:each) { create :full_user }
      it { should validate_uniqueness_of(:email).case_insensitive }
      it { should validate_uniqueness_of(:openid_uid).scoped_to :openid_provider }
    end
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

  describe "#recent_rounds" do
    subject { create :user }
    it "returns the most recent 20 rounds" do
      subject.recent_rounds.to_sql.should include('LIMIT 20')
    end

    it "filters out nil differentials" do
      subject.recent_rounds.to_sql.should include('differential IS NOT NULL')
    end
  end
end
