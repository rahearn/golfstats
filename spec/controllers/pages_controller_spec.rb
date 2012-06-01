require 'spec_helper'

describe PagesController do

  let(:user) { create :user }

  describe "GET :home" do
    context "as a guest" do
      it "responds with success" do
        get :home
        response.should be_success
      end

      it "renders :home" do
        get :home
        response.should render_template :guest_home
      end

      it "extends HomeScreenPresentation" do
        controller.should_receive(:extend).with HomeScreenPresentation
        get :home
      end
    end

    context "when signed in" do
      before(:each) { sign_in user }

      it "responds with success" do
        get :home
        response.should be_success
      end

      it "renders :user_home" do
        get :home
        response.should render_template :user_home
      end

      it "should extend current user with HomeScreenPresentation" do
        controller.stub(:current_user).and_return user
        user.should_receive(:extend).with HomeScreenPresentation
        get :home
      end
    end
  end
end
