require 'spec_helper'

describe CoursesController do

  describe "GET :index" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET :show" do
    let(:course)  { create :course }
    before(:each) { get :show, :id => course.id }

    it { should respond_with :success }
    it { should assign_to(:course).with(course) }
  end

  describe "GET :new" do
    before(:each) do
      sign_in create :user
      get :new
    end

    it { should respond_with :success }
    it { should assign_to(:course).with_kind_of Course }
  end

  describe "POST :create" do
    let(:course) { attributes_for :course }
    before(:each) do
      sign_in create :user
      post :create, :course => course
    end

    it { should respond_with :redirect }

    it "creates a new course" do
      created = assigns :course
      created.should be_persisted
      created.name.should     == course[:name]
      created.location.should == course[:location]
    end
  end

end
