require 'spec_helper'

describe Numeric do

  describe "#numeric?" do
    it { 10.should be_numeric }
    it { 10.01.should be_numeric }
  end

end
