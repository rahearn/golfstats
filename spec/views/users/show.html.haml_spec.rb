require 'spec_helper'

describe "users/show" do
  let(:user) { build_stubbed :full_user }
  before(:each) do
    view.stub(:can?).with(:edit, user).and_return true
    assign :user, user
    render
  end

  it "displays the user's email" do
    rendered.should include "<em>Email:</em>\n#{user.email}"
  end

  it "displays the user's openid" do
    rendered.should include "<em>OpenId:</em>\n#{user.openid_uid}"
  end

  it "displays a link to the edit profile page" do
    rendered.should include %{<a href="#{edit_user_path user}">Edit Profile</a>}
  end
end
