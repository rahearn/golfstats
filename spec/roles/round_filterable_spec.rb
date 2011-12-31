require 'spec_helper'

describe RoundFilterable do
  let(:course) { create :course }
  subject do
    create(:user).tap do |u|
      u.extend RoundFilterable
    end
  end

  describe "#sorted_rounds" do
    before(:each) do
      5.times do
        subject.rounds.create attributes_for(:round, :course => course)
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

  describe "#recent_rounds" do
    it "returns the most recent 20 rounds" do
      subject.recent_rounds.to_sql.should include('LIMIT 20')
    end
  end
end
