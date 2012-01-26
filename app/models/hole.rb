class Hole
  include Mongoid::Document

  field :hole,         :type => Integer
  field :length,       :type => Integer
  field :handicap,     :type => Integer
  field :par,          :type => Integer
  field :score,        :type => Integer
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

  private

  def needs_par?
    on_teebox? || score?
  end

  def on_teebox?
    holed.is_a? Teebox
  end

end
