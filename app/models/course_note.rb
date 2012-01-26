class CourseNote < ActiveRecord::Base

  belongs_to :user
  belongs_to :course

  validates_presence_of :user, :course

  validates_uniqueness_of :course_id, :scope => :user_id

end
