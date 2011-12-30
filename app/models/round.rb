class Round < ActiveRecord::Base

  belongs_to :user

  belongs_to :course

  delegate :id, :name, :to => :course, :prefix => true

  attr_readonly :user, :course, :date, :score, :differential


  validates_presence_of :user, :course, :date, :score, :differential, :on => :create

  validate :scorecard_valid, :if => :scorecard_id?, :on => :create


  before_validation :calculate_differential, :on => :create
  after_create :link_scorecard, :if => :scorecard_id?


  def scorecard
    @scorecard ||= Scorecard.find scorecard_id if scorecard_id?
  end

  def scorecard=(sc)
    if sc.is_a? Scorecard
      @scorecard = sc
      else
      @scorecard = Scorecard.create sc
      self.score = @scorecard.score
    end
    self.scorecard_id = @scorecard.id.to_s
    @scorecard
  end

  private

  def calculate_differential
    if score_changed?
      self.differential = score
    end
  end

  def scorecard_valid
    errors.add(:scorecard, 'is invalid') unless scorecard.valid?
  end

  def link_scorecard
    scorecard.round = self
    scorecard.save
  end
end
