require 'spec_helper'

describe PagesController do

  let(:user) { create :user }

  describe "GET :home" do
    context "as a guest" do
      it "responds with success" do
        get :home
        response.should be_success
      end
    end

    context "when signed in" do
      before(:each) do
        sign_in user
        get :home
      end

      it { should respond_with :redirect }

      context "with no activity" do
        it { should redirect_to add_round_path }
      end

      context "with a round" do
        let(:user) { create(:round).user }
        it { should redirect_to activity_path }
      end
    end
  end
end
