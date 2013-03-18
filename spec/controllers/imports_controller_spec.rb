require 'spec_helper'

describe ImportsController do

  let(:user) { create :user }

  describe "POST :create" do
    it "redirects when not logged in" do
      post :create, :user_id => user.id
      response.should be_redirect
    end

    context "when signed in" do
      let(:legacy_file) { Rack::Test::UploadedFile.new Rails.root.join('spec', 'data', 'golfstats_data.xml') }
      before(:each) do
        sign_in user
        post :create, :user_id => user.id, :file => legacy_file
      end
      after(:each) { legacy_file.close }

      it { should respond_with :redirect }
      specify { user.reload.rounds.count.should be > 0 }
    end
  end
end
