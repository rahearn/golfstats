# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teebox do
    tees 'white'
    course
    slope 120
    rating 72.1
    holes do
      (1..18).each.map do |hole|
        FactoryGirl.build :teebox_hole, :hole => hole
      end
    end
  end
end
