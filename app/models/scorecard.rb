class Scorecard
  include Mongoid::Document

  field :tees,       :type => String
  field :statistics, :type => Hash
  field :length,     :type => Integer
  field :par,        :type => Integer
  field :score,      :type => Integer
  field :round_id,   :type => Integer

  embeds_many :holes, :as => :holed
  accepts_nested_attributes_for :holes


  validates_presence_of :tees

  validates_presence_of :length

  validates_presence_of :par

  validates_presence_of :score


  before_validation :sum_scorecard, :on => :create


  def round
    @round ||= Round.find round_id if round_id?
  end

  def round=(r)
    @round        = r
    self.round_id = r.id
    extend TeeboxCreator
    create_teebox if create_teebox?
  end

  private

  def sum_scorecard
    self.score  = holes.sum :score
    self.length = holes.sum :length
    self.par    = holes.sum :par
  end

end
