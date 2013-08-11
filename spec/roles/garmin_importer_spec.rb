require 'spec_helper'

describe GarminImporter do
  let(:garmin_file) { File.open Rails.root.join 'spec', 'support', 'garmin_file.xml' }
  let(:round) { build_stubbed :pre_import_round, garmin_file: garmin_file }
  subject { round.tap { |r| r.extend GarminImporter } }
  after(:each) { garmin_file.close }

  describe '#import_round' do
    before(:each) { subject.import_round }
    it 'saves scorecard details' do
      s = round.scorecard
      s.score.should == 109
      s.par.should == 69
      s.stat_order.should == ['Putts', 'FIR', 'GIR']
      s.totals['0'].should == 33
      s.totals['1'].should == 6
      s.totals['2'].should == 2
    end
  end
end