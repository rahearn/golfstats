class Hole
  include Mongoid::Document

  field :hole,     :type => Integer
  field :length,   :type => Integer
  field :handicap, :type => Integer
  field :par,      :type => Integer
  field :score,    :type => Integer

  embedded_in :holed, :polymorphic => true


  validates_presence_of :hole
  validates_uniqueness_of :hole
  validates_numericality_of :hole, :less_than_or_equal_to => 18

  validates_presence_of :par

  validates_presence_of :score, :if => :scored?

  validates_uniqueness_of :handicap
  validates_numericality_of :handicap, :less_than_or_equal_to => 18

  private

  def scored?
    holed.is_a? Scorecard
  end
end
