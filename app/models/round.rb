class Round < ActiveRecord::Base

  belongs_to :user

  belongs_to :course

  delegate :id, :name, :to => :course, :prefix => true


  validates_presence_of :user, :course, :date, :score

  validates_presence_of :slope
  validates_numericality_of :slope,
    :less_than_or_equal_to    => 155,
    :greater_than_or_equal_to => 55,
    :only_integer             => true

  validates_presence_of :rating
  validates_numericality_of :rating

  validate :scorecard_valid, :if => :scorecard_id?


  before_save :calculate_differential
  after_create :link_scorecard, :if => :scorecard_id?
  after_save :update_user_handicap


  default_scope order 'date DESC'


  def scorecard
    @scorecard ||= Scorecard.find scorecard_id if scorecard_id?
  end

  def scorecard=(sc)
    @scorecard = if sc.is_a? Scorecard
                   sc
                 elsif scorecard_id?
                   scorecard.tap do |scorecard|
                     scorecard.update_attributes(sc)
                     self.score = scorecard.score
                   end
                 else
                   Scorecard.create(sc.merge(:slope => slope)).tap do |sc|
                     self.score = sc.score
                   end
                 end.tap { |sc| self.scorecard_id = sc.id.to_s }
  end

  private

  def scorecard_valid
    unless scorecard.valid?
      errors.add(:scorecard, 'is invalid')
      scorecard.holes.each do |h|
        Rails.logger.error "Hole #{h.hole} errors: #{h.errors.full_messages}" if h.errors.present?
      end
    end
  end

  def calculate_differential
    extend DifferentialCalculator
    self.differential = calculate
  end

  def link_scorecard
    scorecard.round = self
    scorecard.save
  end

  def update_user_handicap
    user.extend HandicapCalculator
    user.update_handicap!
  end
end
