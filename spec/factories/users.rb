FactoryGirl.define do
  sequence :email do |n|
    "example#{n}@email.com"
  end

  factory :user do
    sequence(:openid_uid) { |n| "https://my-openid.org/#{n}" }

    factory :full_user do
      email
      sequence(:name) { |n| "Golfer #{n}" }
    end

    factory :female_user do
      gender 'female'
    end
  end
end
