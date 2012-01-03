class Scorecard
  include Mongoid::Document

  field :tees,       :type => String
  field :slope,      :type => Integer
  field :rating,     :type => Float
  field :statistics, :type => Hash
  field :length,     :type => Integer
  field :par,        :type => Integer
  field :score,      :type => Integer
  field :round_id,   :type => Integer
  field :user_id,    :type => Integer

  embeds_many :holes, :as => :holed
  accepts_nested_attributes_for :holes


  validates_presence_of :tees

  validates_presence_of :length

  validates_presence_of :par

  validates_presence_of :score

  validates_presence_of :slope
  validates_numericality_of :slope,
    :less_than_or_equal_to    => 155,
    :greater_than_or_equal_to => 55,
    :only_integer             => true

  validates_presence_of :rating
  validates_numericality_of :rating


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
  end

end
