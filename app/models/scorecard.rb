class Scorecard
  include Mongoid::Document

  field :tee,        :type => String
  field :statistics, :type => Hash
  field :length,     :type => Integer
  field :par,        :type => Integer
  field :score,      :type => Integer
  field :round_id,   :type => Integer

  embeds_many :holes
  accepts_nested_attributes_for :holes


  validates_presence_of :tee

  validates_presence_of :length

  validates_presence_of :par

  validates_presence_of :score

  before_validation :sum_scorecard, :on => :create
  after_create :set_round

  def round
    @round ||= Round.find round_id
  end

  def round=(r)
    @round = nil
    self.round_id = r.id
  end

  private

  def sum_scorecard
    self.score  = holes.sum(:score)  unless self.score.present?
    self.length = holes.sum(:length) unless self.length.present?
    self.par    = holes.sum(:par)    unless self.par.present?
  end

  def set_round
    unless round_id.nil?
      round.scorecard = self
      round.score     = score
      round.save
    end
  end
end
