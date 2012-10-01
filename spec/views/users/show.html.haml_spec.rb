require 'spec_helper'

describe "users/show" do
  let(:user) { build_stubbed :full_user, openid_provider: 'open_id' }
  before(:each) do
    view.stub(:can?).with(:edit, user).and_return true
    assign :user, user
    render
  end

  it "displays the user's email" do
    rendered.should =~ /<em>Email:<\/em>\s+#{user.email}/
  end

  it "displays the user's openid" do
    rendered.should =~ /<em>OpenId:<\/em>\s+#{user.openid_uid}/
  end

  context "facebook user" do
    let(:user) { build_stubbed :full_user, openid_provider: 'facebook' }

    it "displays the openid provider" do
      rendered.should =~ /<em>OpenId:<\/em>\s+Facebook:/
    end
  end

  it "displays a link to the edit profile page" do
    rendered.should include %{<a href="#{edit_user_path user}">Edit Profile</a>}
  end
end
