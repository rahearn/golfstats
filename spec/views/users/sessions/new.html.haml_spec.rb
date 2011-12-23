require 'spec_helper'

describe "users/sessions/new.html.haml" do

  before(:each) { render }

  it "displays a link to a google signin" do
    rendered.should include link_to("Sign in with Google", "/users/auth/google")
  end

  it "has a form for entering a custom openid" do
    rendered.should include '<form accept-charset="UTF-8" action="/users/auth/open_id" method="get">'
  end
end
