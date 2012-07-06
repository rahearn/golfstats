require 'spec_helper'

describe 'users/edit' do
  let(:user) { build_stubbed :user }
  before(:each) do
    assign :user, user
    render
  end

  it "has a form for updating your profile" do
    rendered.should include %{<form accept-charset="UTF-8" action="#{user_path user}"}
  end

  it "includes an input box for name" do
    rendered.should include '<input id="user_name" name="user[name]" size="30" type="text" />'
  end

  it "includes an input box for email" do
    rendered.should include '<input id="user_email" name="user[email]" size="30" type="email" />'
  end

  it "includes two radio boxes for gender" do
    rendered.should include '<input checked="checked" id="user_gender_male" name="user[gender]" type="radio" value="male" />'
    rendered.should include '<input id="user_gender_female" name="user[gender]" type="radio" value="female" />'
  end
end
