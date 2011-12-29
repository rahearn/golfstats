# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scorecard do
    tees "white"
    length 6063
    par 71
    score 100
  end
end
