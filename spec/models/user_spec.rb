require 'spec_helper'

describe User do

  it { should validate_presence_of :openid_uid }
  it { should validate_format_of(:email).with 'example@mail.com' }
  it { should validate_format_of(:email).not_with 'missing_tld@email' }

  context "require db users" do
    before(:all) { User.create! :email => 'example@email.com', :openid_uid => 'https://my-openid.com' }
    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :openid_uid }
  end

end
