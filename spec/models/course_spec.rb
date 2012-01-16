require 'spec_helper'

describe Course do

  describe "relations" do
    it { should have_many :rounds }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :location }
    it { should have_readonly_attribute :name }
    it { should have_readonly_attribute :location }
    context "requre db users" do
      before(:each) { create :course }
      it { should validate_uniqueness_of(:name).scoped_to :location }
    end
  end
end
