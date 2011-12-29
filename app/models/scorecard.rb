class Scorecard
  include Mongoid::Document

  field :tees,       :type => String
  field :statistics, :type => Hash
  field :length,     :type => Integer
  field :par,        :type => Integer
  field :score,      :type => Integer
  field :round_id,   :type => Integer

  embeds_many :holes, :as => :holed
  accepts_nested_attributes_for :holes,
    :reject_if => proc { |attributes| attributes[:score].blank? }


  validates_presence_of :tees

  validates_presence_of :length

  validates_presence_of :par

  validates_presence_of :score

  before_validation :sum_scorecard, :on => :create
  after_create :set_round,     :if => :round_id?
  after_create :update_teebox, :if => :can_update_teebox?

  def round
    @round ||= Round.find round_id if round_id?
  end

  def round=(r)
    @round = r
    self.round_id = r.id
  end

  private

  def sum_scorecard
    self.score  = holes.sum(:score)  unless self.score.present?
    self.length = holes.sum(:length) unless self.length.present?
    self.par    = holes.sum(:par)    unless self.par.present?
  end

  def set_round
    round.scorecard = self
    round.score     = score
    round.save
  end

  def can_update_teebox?
    round_id? && holes.length == 18
  end

  def update_teebox
    teebox = Teebox.find_or_create_by :tees => tees, :course_id => round.course_id
    if teebox.holes.count < 18
      teebox.holes.delete_all
      holes.each do |h|
        teebox.holes.build(
          :hole     => h.hole,
          :length   => h.length,
          :par      => h.par,
          :handicap => h.handicap
        )
      end
    else
      default_holes = teebox.holes.each
      holes.each do |h|
        dh          = default_holes.next
        dh.length   = h.length
        dh.par      = h.par
        dh.handicap = h.handicap if h.handicap.present?
      end
    end
    teebox.save!
  end
end
