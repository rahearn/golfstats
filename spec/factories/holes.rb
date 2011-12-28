# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hole do
    sequence(:hole)     { |n| (n % 18) + 1 }
    sequence(:handicap) { |n| (n % 18) + 1 }
    score               { rand(3..5) }
    length 375
    par 4

    factory :parred_hole do
      score 4
    end
  end
end
