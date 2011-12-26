class Scorecard
  include Mongoid::Document

  field :tee,        :type => String
  field :statistics, :type => Hash
  field :length,     :type => Integer
  field :par,        :type => Integer
  field :score,      :type => Integer

  embeds_many :scored_holes


  validates_presence_of :tee

  validates_presence_of :length

  validates_presence_of :par

  validates_presence_of :score
end
