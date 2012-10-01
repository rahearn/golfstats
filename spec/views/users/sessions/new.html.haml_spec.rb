require 'spec_helper'

describe "users/sessions/new" do

  before(:each) { render }

  it "displays a link to a google signin" do
    rendered.should include link_to("Google", "/users/auth/google", class: :pop)
  end

  it "displays a link to a twitter signin" do
    rendered.should include link_to('Twitter', '/users/auth/twitter', class: :pop)
  end

  it "has a form for entering a custom openid" do
    rendered.should include '<form accept-charset="UTF-8" action="/users/auth/open_id" method="get">'
  end
end
