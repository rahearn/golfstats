FactoryGirl.define do
  factory :round do
    sequence(:date) { |n| "2011-08-#{(n % 31) + 1}" }
    score 95
    sequence(:notes) { |n| "Round ##{n}" }
    user
    course
  end
end
