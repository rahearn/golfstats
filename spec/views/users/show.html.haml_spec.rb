require 'spec_helper'

describe "users/show.html.haml" do
  before(:all) do
    User.destroy_all
    assign :user, User.create!(:email => 'example@email.com', :openid_uid => 'https://my-openid.com')
  end
  before(:each) { render }

  it "displays the user's email" do
    rendered.should include "<em>Email:</em>\nexample@email.com"
  end

  it "displays the user's openid" do
    rendered.should include "<em>OpenId:</em>\nhttps://my-openid.com"
  end
end
