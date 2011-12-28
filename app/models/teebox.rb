class Teebox
  include Mongoid::Document

  field :tees,      :type => String
  field :course_id, :type => Integer


  validates_presence_of :tees
  validates_uniqueness_of :tees, :scope => :course_id

  validates_presence_of :course_id


  def course
    @course ||= Course.find course_id
  end

  def course=(c)
    @course = nil
    self.course_id = c.id
  end
end
