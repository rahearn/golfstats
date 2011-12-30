# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scorecard do
    tees "white"
    slope 113
    rating 70.2
    holes do
      (1..18).each.map do |hole|
        FactoryGirl.build :hole, :hole => hole
      end
    end

    factory :front_nine_scorecard do
      holes do
        (1..9).each.map do |hole|
          FactoryGirl.build :hole, :hole => hole
        end
      end
    end

    factory :blank_scorecard do
      holes nil
    end
  end
end
