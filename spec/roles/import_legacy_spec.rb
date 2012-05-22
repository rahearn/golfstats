require 'spec_helper'

describe ImportLegacy do

  subject { build_stubbed(:user).tap { |u| u.extend ImportLegacy } }

  describe "#import_legacy" do
    subject { create(:user).tap { |u| u.extend ImportLegacy } }

    context "with well formed file" do
      let(:legacy_file) do
        File.open Rails.root.join('spec', 'data', 'golfstats_data.xml')
      end
      before(:each) { subject.import_legacy legacy_file }
      after(:each) { legacy_file.close }

      specify { Course.count.should == 1 }
      specify { Teebox.count.should == 1 }
      specify { CourseNote.count.should == 1 }
      specify { subject.rounds.should_not be_empty }
      specify { subject.rounds.first.scorecard.should be_present }
      it { should be_import_successful }
      specify { subject.import_done?.should be_true }
    end

    context "with no file" do
      before(:each) { subject.import_legacy nil }

      specify { subject.rounds.should be_empty }
      specify { Course.count.should == 0 }
      it { should_not be_import_successful }
    end
  end
end
