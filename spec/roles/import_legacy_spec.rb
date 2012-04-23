require 'spec_helper'

describe ImportLegacy do
  let(:legacy_file) { File.open Rails.root.join('spec', 'support', 'golfstats_data.xml') }
  after(:each) { legacy_file.close }

  subject do
    build_stubbed(:user).tap do |u|
      u.extend ImportLegacy
    end
  end

  describe "#show_import?" do
    specify { subject.show_import?.should be_true }

    context "after import" do
      before(:each) { subject.import_done = true }

      specify { subject.show_import?.should be_false }
    end
  end
end
