require 'spec_helper'

describe CourseHandicapController do

  let(:user) { create :user }

  describe 'GET :show' do
    context "as guest" do
      before(:each) { get :show, slope: 117 }
      it { should respond_with :redirect }
    end

    context "as user" do
      before(:each) do
        sign_in user
        get :show, slope: 117
      end

      it { should respond_with :success }
      it { should assign_to(:handicap).with 38 }
    end
  end

end
