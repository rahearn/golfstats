require 'spec_helper'

describe Course do

  it { should validate_presence_of :name }
  it { should validate_presence_of :location }
  it { should have_readonly_attribute :name }
  it { should have_readonly_attribute :location }

  context "requre db users" do
    before(:all) { create :course }
    it { should validate_uniqueness_of(:name).scoped_to :location }
  end
end
