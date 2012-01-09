class Teebox
  include Mongoid::Document

  field :tees,      :type => String
  field :course_id, :type => Integer
  field :slope,     :type => Integer
  field :rating,    :type => Float

  embeds_many :holes, :as => :holed


  validates_presence_of :tees
  validates_uniqueness_of :tees, :scope => :course_id

  validates_presence_of :course_id

  validates_presence_of :slope
  validates_numericality_of :slope,
    :less_than_or_equal_to    => 155,
    :greater_than_or_equal_to => 55,
    :only_integer             => true

  validates_presence_of :rating
  validates_numericality_of :rating


  def course
    @course ||= Course.find course_id
  end

  def course=(c)
    @course = c
    self.course_id = c.id
  end
end
