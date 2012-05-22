require 'spec_helper'

describe UsersController do

  let(:user) { create :user }

  describe "GET :show" do
    it "redirects when not logged in" do
      get :show, :id => user.id
      response.should be_redirect
    end

    context "when signed in" do
      before(:each) do
        sign_in user
        get :show, :id => user.id
      end

      it { should respond_with :success }
      it { should assign_to(:user).with user }
      specify { assigns(:user).respond_to?(:import_legacy).should be_true }
    end
  end

end
