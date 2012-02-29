class Scorecard
  include Mongoid::Document

  field :tees,       :type => String
  field :length,     :type => Integer
  field :par,        :type => Integer
  field :score,      :type => Integer
  field :round_id,   :type => Integer
  field :user_id,    :type => Integer
  field :stat_order, :type => Array, :default => []
  field :totals,     :type => Hash, :default => {}

  embeds_many :holes, :as => :holed
  accepts_nested_attributes_for :holes

  attr_writer :slope


  validates_presence_of :tees

  validates_presence_of :length

  validates_presence_of :par

  validates_presence_of :score

  validates_presence_of :user_id

  before_validation :sum_scorecard


  def round
    @round ||= Round.find round_id if round_id?
  end

  def round=(r)
    @round        = r
    self.round_id = r.id
    extend TeeboxCreator
    create_teebox if create_teebox?
  end

  def slope
    @slope || round.slope
  end

  def rating
    round.rating
  end

  def user
    @user ||= User.find user_id if user_id?
  end

  private

  def sum_scorecard
    holes.select { |h| h.score? }.each do |h|
      h.extend EquitableStrokeCalculator
      h.score = h.calculate
    end
    self.score  = holes.sum :score
    self.length = holes.sum :length
    self.par    = holes.sum :par
    stat_order.each_index do |cs|
      key = cs.to_s
      next unless holes.any? { |h| h.custom_stats[key].numeric? }
      self.totals[key] = holes.map { |h| h.custom_stats[key].to_i }.reduce(:+)
    end
  end

end
