require 'spec_helper'

describe Course do

  describe "relations" do
    it { should have_many :rounds }
    it { should have_many :notes }
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

  describe "#notes" do
    describe "#for_user" do
      subject { create :course }
      let!(:note) { create :course_note, :course => subject }
      let(:user) { note.user }

      it "returns the note for a given user" do
        subject.notes.for_user(user).should == note
      end

      it "returns nil for a user with no note" do
        subject.notes.for_user(create :user).should be_nil
      end
    end
  end
end
