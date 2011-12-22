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

      it "returns http success" do
        response.should be_success
      end

      it "assigns current_user to @user" do
        assigns(:user).should == user
      end
    end
  end

end
