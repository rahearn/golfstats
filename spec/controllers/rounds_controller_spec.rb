require 'spec_helper'

describe RoundsController do

  describe "GET :index" do
    let!(:course) { create :course }

    it "returns http success when logged in" do
      sign_in create :user
      get :index, :course_id => course.id
      response.should be_success
    end

    it "redirects when not logged in" do
      get :index, :course_id => course.id
      response.should be_redirect
    end

    it 'renders all_rounds when course id is nil' do
      sign_in create :user
      get :index
      response.should render_template :all_rounds
    end
  end

  describe "GET :show" do
    let(:round) { create :round }

    context "with my round" do
      before(:each) do
        sign_in round.user
        get :show, :id => round.id
      end

      it { should respond_with :success }
    end

    context "for someone else's round" do
      before(:each) do
        sign_in create :user
        get :show, :id => round.id
      end

      it { should respond_with :redirect }
    end
  end

  describe "GET :new" do
    let(:course) { create :course }
    before(:each) do
      sign_in create :user
      get :new, :course_id => course.id
    end

    it { should respond_with :success }
  end

  describe "POST :create" do
    let(:user)   { create :user }
    let(:course) { create :course }
    let(:round)  { attributes_for :round }
    before(:each) do
      sign_in user
      post :create, :course_id => course.id, :round => round
    end

    it { should respond_with :redirect }

    it "creates a new round" do
      created = assigns :round
      created.should be_persisted
      created.user.should   == user
      created.course.should == course
      created.date.should   == Date.parse(round[:date])
    end
  end

end
