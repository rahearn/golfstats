require 'spec_helper'

describe Users::SessionsController do

  describe "GET :new" do
    it "redirects when logged in" do
      sign_in create :user
      get :new
      response.should be_redirect
    end

    it "returns http success when not logged in" do
      get :new
      response.should be_success
    end
  end

  describe "GET :destroy" do
    it "redirects when not logged in" do
      get :destroy
      response.should be_redirect
    end

    context "when logged in" do
      before(:each) do
        sign_in create :user
        get :destroy
      end

      it "redirects" do
        response.should be_redirect
      end

      it "sets flash notice" do
        flash[:notice].should == 'Signed out successfully.'
      end
    end
  end

end
