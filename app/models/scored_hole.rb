class ScoredHole
  include Mongoid::Document

  field :hole,     :type => Integer
  field :length,   :type => Integer
  field :handicap, :type => Integer
  field :par,      :type => Integer
  field :score,    :type => Integer

  embedded_in :scorecard


  validates_presence_of :hole

  validates_presence_of :par

  validates_presence_of :score
end
