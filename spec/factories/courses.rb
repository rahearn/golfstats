# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    sequence(:name) { |n| "Royal #{n} Links" }
    location "Baltimore, MD"
  end
end
