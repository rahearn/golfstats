class Round < ActiveRecord::Base

  belongs_to :user

  belongs_to :course

  delegate :name, :to => :course, :prefix => true

  attr_readonly :user, :course, :date, :score, :differential

  validates_presence_of :user, :course, :date, :score, :differential, :on => :create

  before_validation :calculate_differential, :on => :create

  private

  def calculate_differential
    self.differential = score
  end
end
