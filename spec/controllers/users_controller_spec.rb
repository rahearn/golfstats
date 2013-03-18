require 'spec_helper'

describe UsersController do

  let(:user) { create :user }

  describe "GET :show" do
    it "redirects when not logged in" do
      get :show, id: user.id
      response.should be_redirect
    end

    context "when signed in" do
      before(:each) do
        sign_in user
        get :show, id: user.id
      end

      it { should respond_with :success }
      specify { assigns(:user).respond_to?(:import_legacy).should be_true }
    end
  end

  describe "GET :edit" do
    it "redirects when not logged in" do
      get :edit, id: user.id
      response.should be_redirect
    end

    context "when signed in" do
      before(:each) do
        sign_in user
        get :edit, id: user.id
      end

      it { should respond_with :success }
    end
  end

  describe "PUT :update" do
    it "redirects when not logged in" do
      put :update, id: user.id
      response.should be_redirect
    end

    context "when signed in" do
      before(:each) do
        sign_in user
        put :update, id: user.id, user: {email: new_email}
      end

      context "with valid params" do
        let(:new_email) { generate :email }

        it { should redirect_to user }
        it { should set_the_flash.to 'You have updated your profile successfully.' }
        specify { assigns(:user).email.should == new_email }
      end

      context "with invalid params" do
        let(:new_email) { 'bad@format' }

        it { should render_template :edit }
      end
    end
  end
end
