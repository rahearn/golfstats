require 'spec_helper'

describe UsersController do

  describe "GET :show" do
    it "redirects when not logged in" do
      get :show
      response.should be_redirect
    end

    context "when signed in" do
      let(:user) { create :user }
      before(:each) do
        sign_in user
        get :show
      end

      it { should respond_with :success }
      it { should assign_to(:user).with user }
    end
  end

end
