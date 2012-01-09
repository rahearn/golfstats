require 'spec_helper'

describe PagesController do

  let(:user)    { create :user }
  before(:each) { sign_in user }

  describe "GET :home" do

    it "responds with success" do
      get :home
      response.should be_success
    end

    it "should extend current user with HomeScreenPresentation" do
      controller.stub(:current_user).and_return user
      user.should_receive(:extend).with HomeScreenPresentation
      get :home
    end
  end
end