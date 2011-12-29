class Round < ActiveRecord::Base

  belongs_to :user

  belongs_to :course

  delegate :id, :name, :to => :course, :prefix => true

  attr_readonly :user, :course, :date, :score, :differential

  validates_presence_of :user, :course, :date, :score, :differential, :on => :create

  validate :scorecard_valid, :if => :scorecard_id?

  before_validation :calculate_differential
  after_create :set_scorecard, :if => :scorecard_id?

  def scorecard
    @scorecard ||= Scorecard.find scorecard_id if scorecard_id?
  end

  def scorecard=(sc)
    if sc.is_a? Scorecard
      @scorecard = sc
      self.scorecard_id = sc.id.to_s
    else
      @scorecard = Scorecard.create sc
      self.scorecard_id = @scorecard.id.to_s
      self.score = @scorecard.score
    end
  end

  private

  def calculate_differential
    if score_changed?
      self.differential = score
    end
  end

  def scorecard_valid
    errors.add(:scorecard, 'is invalid') unless @scorecard.valid?
  end

  def set_scorecard
    scorecard.round = self
    scorecard.save
  end
end
