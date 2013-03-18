require 'spec_helper'

describe CourseNotesController do

  let(:user)    { create :user }
  let(:course)  { create :course }
  before(:each) { sign_in user }

  describe "GET :new" do
    before(:each) { get :new, :course_id => course.id }

    it { should respond_with :success }
  end

  describe "POST :create" do
    let(:note) { attributes_for :course_note }
    before(:each) { post :create, :course_id => course.id, :course_note => note }

    it { should respond_with :redirect }

    it "creates the note" do
      created = assigns :course_note
      created.note.should == note[:note]
      created.course.should == course
      created.user.should == user
    end
  end

  context "requires a note" do
    let!(:note) { create :course_note, :course => course, :user => user }

    describe "GET :edit" do
      before(:each) { get :edit, :course_id => course.id }

      it { should respond_with :success }
    end

    describe "PUT :update" do
      before(:each) { put :update, :course_id => course.id, :course_note => {:note => 'updated'} }

      it { should respond_with :redirect }

      it "should update the note" do
        updated = assigns :course_note
        updated.note.should == 'updated'
      end
    end

    describe "DELETE :destroy" do
      before(:each) { delete :destroy, :course_id => course.id }

      it { should respond_with :redirect }

      it "should delete the note" do
        deleted = assigns :course_note
        deleted.should be_destroyed
      end
    end
  end

end
