class Course < ActiveRecord::Base

  has_many :rounds

  has_many :notes, :class_name => 'CourseNote' do
    def for_user(user)
      where(:user_id => user.id).first
    end
  end

  attr_readonly :name, :location

  validates_presence_of :name
  validates_presence_of :location

  validates_uniqueness_of :name, :scope => :location, :on => :create

  def teeboxes
    @teeboxes ||= Teebox.where(:course_id => id).sort_by { |teebox| tee_order teebox.tees }
  end

  private

  STD_TEES = {
    'red'          => 0,
    'gold'         => 10,
    'white'        => 20,
    'blue'         => 30,
    'black'        => 40,
    'championship' => 45
  }.freeze

  def tee_order(tee)
    STD_TEES[tee.downcase] || 50
  end

end
