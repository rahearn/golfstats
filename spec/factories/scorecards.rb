# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scorecard do
    tees "white"
    length 6063
    par 71
    score 100
  end

  factory :filled_in_scorecard, :class => Scorecard do
    tees "white"
    holes do
      (1..18).each.map do |hole|
        FactoryGirl.build :hole, :hole => hole
      end
    end
  end
end
