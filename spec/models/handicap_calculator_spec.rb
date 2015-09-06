require 'spec_helper'

describe HandicapCalculator do
  let(:user)   { build_stubbed :user }
  let(:course) { build_stubbed :course }
  let(:rounds) do
    [
      build_stubbed(:round, :course => course, :user => user, :differential => 10.323),
      build_stubbed(:round, :course => course, :user => user, :differential => 14.212),
      build_stubbed(:round, :course => course, :user => user, :differential => 12.321)
    ]
  end
  subject { described_class.new user }

  describe "#call" do
    context "with useable rounds" do
      let(:expected) { 11.7 }
      before(:each) { subject.stub(:sorted_rounds).and_return rounds }

      it "calculates the handicap" do
        subject.call.should == expected
      end
    end

    it "returns nil when no rounds" do
      subject.call.should be_nil
    end
  end

  describe "#sorted_rounds" do
    let(:user) { create :user }
    let(:course) { create :course }
    before(:each) do
      5.times do
        user.rounds.create! attributes_for(:round, :course_id => course.id)
      end
      subject.stub(:slice_size).and_return 4
    end

    it "limits the count to the #slice_size" do
      subject.sorted_rounds.count.should == 4
    end

    it "sorts the returned rounds by differential" do
      last_value = 0
      subject.sorted_rounds.each do |round|
        round.differential.should >= last_value
        last_value = round.differential
      end
    end
  end
end
