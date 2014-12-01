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

end
