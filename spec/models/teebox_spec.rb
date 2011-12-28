require 'spec_helper'

describe Teebox do
  include Mongoid::Matchers

  describe "validations" do
    it { should validate_presence_of :tees }
    it { should validate_presence_of :course_id }
    context "require db users" do
      before(:all) { create :teebox }
      it { should validate_uniqueness_of(:tees).scoped_to :course_id }
    end
  end

  describe "#course" do
    let(:course) { create :course }
    subject { build_stubbed :teebox, :course_id => course.id }

    it "retrieves the course object" do
      subject.course.should == course
    end
  end

  describe "#course=" do
    let(:course) { create :course }

    it "assigns the correct course_id" do
      subject.course = course
      subject.course_id.should == course.id
    end
  end
end
