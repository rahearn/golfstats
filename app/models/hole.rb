class Hole
  include Mongoid::Document

  field :hole,         :type => Integer
  field :length,       :type => Integer
  field :handicap,     :type => Integer
  field :par,          :type => Integer
  field :score,        :type => Integer
  field :net_score,    :type => Integer
  field :custom_stats, :type => Hash

  embedded_in :holed, :polymorphic => true


  validates_presence_of :hole
  validates_uniqueness_of :hole
  validates_numericality_of :hole,
    :less_than_or_equal_to => 18, :only_integer => true

  validates_presence_of :length, :if => :on_teebox?
  validates_numericality_of :length,
    :greater_than => 0, :only_integer => true, :allow_nil => true

  validates_presence_of :par, :if => :needs_par?
  validates_numericality_of :par,
    :greater_than => 0, :only_integer => true, :allow_nil => true

  validates_numericality_of :score,
    :greater_than => 0, :only_integer => true, :allow_nil => true

  validates_uniqueness_of :handicap, :allow_nil => true
  validates_numericality_of :handicap,
    :less_than_or_equal_to => 18, :only_integer => true, :allow_nil => true


  def valid_for_teebox?
    length.present? # && valid for scorecard
  end

  def score_name
    return '' if par.blank? || score.blank?
    offset_name(score - par)
  end

  def net_score_name
    return '' if par.blank? || net_score.blank?
    offset_name(net_score - par)
  end

  def set_net_score
    if score? && handicap? && holed.respond_to?(:course_handicap?) && holed.course_handicap?
      course_handicap = holed.course_handicap.abs
      strokes = (course_handicap / 18) + ((course_handicap % 18) >= handicap ? 1 : 0)
      if holed.course_handicap >= 0
        self.net_score = score - strokes
      else
        self.net_score = score + strokes
      end
    end
  end

  private

  def needs_par?
    on_teebox? || score?
  end

  def on_teebox?
    holed.is_a? Teebox
  end

  def offset_name(offset)
    if offset == 0
      'par'
    elsif offset == 1
      'bogey'
    elsif offset >= 2
      'dbl-bogey'
    elsif offset == -1
      'birdie'
    elsif offset <= -2
      'eagle'
    else
      ''
    end
  end
end
