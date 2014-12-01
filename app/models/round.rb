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


  before_validation :garmin_import, :if => :import?, :on => :create
  before_save :calculate_differential, unless: :partial_round?
  after_create :link_scorecard, :if => :scorecard_id?
  after_save :update_user_handicap
  after_destroy :destroy_scorecard

  default_scope order 'date DESC'


  attr_accessor :garmin_file, :tees, :course_handicap

  def scorecard
    @scorecard ||= Scorecard.find scorecard_id if scorecard_id?
  end

  def scorecard=(sc)
    @scorecard = if sc.is_a? Scorecard
                   sc
                 elsif scorecard_id?
                   scorecard.tap do |scorecard|
                     scorecard.update_attributes(sc)
                   end
                 else
                   Scorecard.create sc.merge(:slope => slope)
                 end.tap { |sc| self.score = sc.score; self.scorecard_id = sc.id.to_s }
  end

  def scorecard?
    new_record? || scorecard.present?
  end

  def import?
    garmin_file.present?
  end

  def basic?
    !scorecard? && !import?
  end

  def display_differential
    (differential * 9.6).truncate / 10.0 if differential.present?
  end

  private

  def scorecard_valid
    unless scorecard.valid?
      errors.add(:scorecard, 'is invalid')
      scorecard.holes.each do |h|
        scorecard.errors.add :base, "Hole #{h.hole} errors: #{h.errors.full_messages.join '. '}" if h.errors.present?
      end
      scorecard.errors.delete :holes
    end
  end

  def garmin_import
    extend GarminImporter
    import_round
  end

  def calculate_differential
    if scorecard.present?
      s = scorecard.holes.select { |h| h.score? }.map do |h|
        h.extend EquitableStrokeCalculator
        h.calculate
      end.reduce :+
    else
      s = score
    end
    self.differential = ((s.to_f - rating) * 113.0) / slope
  end


  def partial_round?
    scorecard.present? &&
    (scorecard.holes.length != 18 ||
    scorecard.holes.any? { |h| h.score.blank? })
  end

  def link_scorecard
    scorecard.round = self
    scorecard.save
  end

  def update_user_handicap
    user.extend HandicapCalculator
    user.update_handicap!
  end

  def destroy_scorecard
    scorecard.try :destroy
  end
end
