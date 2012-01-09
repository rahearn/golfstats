require 'spec_helper'

describe PagesController do

  describe "GET :home" do
    let(:user) { mock_model User }

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
