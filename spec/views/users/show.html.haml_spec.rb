require 'spec_helper'

describe "users/show" do
  let(:user) { build_stubbed(:full_user).tap { |u| u.stub(:show_import? => false) } }
  before(:each) do
    assign :user, user
    render
  end

  it "displays the user's email" do
    rendered.should include "<em>Email:</em>\n#{user.email}"
  end

  it "displays the user's openid" do
    rendered.should include "<em>OpenId:</em>\n#{user.openid_uid}"
  end
end
