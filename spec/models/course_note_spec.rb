require 'spec_helper'

describe CourseNote do

  describe "validations" do
    it { should validate_presence_of :user }
    it { should validate_presence_of :course }
    context "require db notes" do
      before(:each) { create :course_note }
      it { should validate_uniqueness_of(:course_id).scoped_to :user_id }
    end
  end

  describe "relations" do
    it { should belong_to :user }
    it { should belong_to :course }
  end
end
