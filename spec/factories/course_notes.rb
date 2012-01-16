# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :course_note do
    note "My thoughts about this course."
    user
    course
  end
end
