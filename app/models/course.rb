class Course < ActiveRecord::Base

  attr_readonly :name, :location

  validates_presence_of :name
  validates_presence_of :location

  validates_uniqueness_of :name, :scope => :location, :on => :create
end
