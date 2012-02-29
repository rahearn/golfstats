require 'spec_helper'

describe Array do
  let(:tester) { mock 'expectations' }
  subject { ['Hello World'] }

  describe "#each_key" do
    it "yields the index as a string" do
      subject.each_key do |key|
        key.should == '0'
      end
    end

    context "with multiple entires" do
      subject { ['Hello', 'World'] }

      it "yields for each entry" do
        tester.should_receive(:good).twice
        subject.each_key { |k| tester.good }
      end
    end
  end

  describe "#each_with_key" do

    it "yields the object and the index as a string" do
      subject.each_with_key do |object, key|
        object.should == 'Hello World'
        key.should == '0'
      end
    end

    context "with multiple entries" do
      subject { ['Hello', 'World'] }

      it "yields for each entry" do
        tester.should_receive(:good).twice
        subject.each_with_key { |k| tester.good }
      end
    end
  end

end
