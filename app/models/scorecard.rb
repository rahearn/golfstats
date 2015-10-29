class Scorecard
  include Mongoid::Document

  field :tees,       :type => String
  field :length,     :type => Integer
  field :par,        :type => Integer
  field :score,      :type => Integer
  field :net_score,  :type => Integer
  field :round_id,   :type => Integer
  field :user_id,    :type => Integer
  field :course_handicap, :type => Integer
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

  after_save :save_teebox

  def round
    @round ||= begin
      Round.find round_id if round_id?
    end
  end

  def round=(r)
    @round        = r
    self.round_id = r.id
    self.tees     = r.tees if tees.blank?
    self.user_id  = r.user_id if user_id.blank?
  end

  def slope
    @slope || round.slope
  end

  def rating
    round.rating
  end

  def user
    @user ||= begin
      User.find user_id if user_id?
    end
  end

  private

  def sum_scorecard
    self.score     = holes.map { |h| h.score || 0 }.reduce :+
    self.net_score = holes.map { |h| h.set_net_score; h.net_score || 0 }.reduce :+
    self.length    = holes.map { |h| h.length || 0 }.reduce :+
    self.par       = holes.map { |h| h.par || 0 }.reduce :+
    stat_order.each_key do |key|
      self.totals[key] = holes.map do |h|
        h.custom_stats[key].true? ? 1 : h.custom_stats[key].to_i
      end.reduce :+
    end
  end

  def save_teebox
    tc = TeeboxCreator.new self
    tc.call if tc.valid?
  end
end
