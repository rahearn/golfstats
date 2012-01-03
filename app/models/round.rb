class Round < ActiveRecord::Base

  belongs_to :user

  belongs_to :course

  delegate :id, :name, :to => :course, :prefix => true

  attr_readonly :user, :course, :date, :score, :differential

  attr_accessor :slope, :rating


  validates_presence_of :user, :course, :date, :score, :on => :create

  validates_presence_of :slope, :rating, :unless => :scorecard_id?
  validates_numericality_of :slope, :rating, :allow_nil => true, :unless => :scorecard_id?

  validate :scorecard_valid, :if => :scorecard_id?, :on => :create


  before_create :calculate_differential
  after_create :link_scorecard, :if => :scorecard_id?
  after_create :update_user_handicap


  default_scope order 'date DESC'


  def scorecard
    @scorecard ||= Scorecard.find scorecard_id if scorecard_id?
  end

  def scorecard=(sc)
    @scorecard = if sc.is_a? Scorecard
                   sc
                 else
                   Scorecard.create(sc).tap { |sc| self.score = sc.score }
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
