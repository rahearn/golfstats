# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scorecard do
    tees "white"
    holes do
      (1..18).each.map do |hole|
        FactoryGirl.build :hole, :hole => hole
      end
    end

    factory :blank_scorecard do
      holes nil
    end
  end
end
