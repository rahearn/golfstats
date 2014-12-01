require 'spec_helper'

describe GarminImporter do
  let(:garmin_file) { File.open Rails.root.join 'spec', 'support', 'garmin_file.xml' }
  let(:round) { build_stubbed :pre_import_round, garmin_file: garmin_file }
  subject { round.tap { |r| r.extend GarminImporter } }
  after(:each) { garmin_file.close }

  describe '#import_round' do
    it 'saves scorecard details' do
      subject.import_round
      s = round.scorecard
      s.score.should == 107
      s.par.should == 69
      s.length.should == 0
      s.stat_order.should == ['Putts', 'FIR', 'GIR']
      s.totals['0'].should == 34
      s.totals['1'].should == 6
      s.totals['2'].should == 3
    end

    context 'pre-existing teebox' do
      let!(:teebox) { create :teebox, course: round.course }
      it 'saves hole lengths' do
        subject.import_round
        s = round.scorecard
        s.length.should == 7200
      end
    end
  end
end
