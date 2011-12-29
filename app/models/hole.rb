class Hole
  include Mongoid::Document

  field :hole,     :type => Integer
  field :length,   :type => Integer
  field :handicap, :type => Integer
  field :par,      :type => Integer
  field :score,    :type => Integer

  embedded_in :holed, :polymorphic => true


  validates_presence_of :hole

  validates_presence_of :par

  validates_presence_of :score, :if => :scored?


  private

  def scored?
    holed.class == Scorecard
  end
end
