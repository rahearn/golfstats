require 'spec_helper'

describe String do

  describe "#true?" do

    %w(t T true TRUE y Y yes YES).each do |try|
      it "#{try} should be true" do
        try.true?.should be_true
      end
    end
    it { "false".true?.should_not be_true }
  end

  describe "#false?" do

    %w(f F false FALSE n N no NO).each do |try|
      it "#{try} should be false" do
        try.false?.should be_true
      end
    end
    it { "true".false?.should_not be_true }

  end

  describe "#numeric?" do

    %w(1,234,567.89 12 -34.1).each do |try|
      it "#{try} should be numeric" do
        try.should be_numeric
      end
    end
    it { "1,2345".should_not be_numeric }
    it { ",234".should_not be_numeric }

  end

end
