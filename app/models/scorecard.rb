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


  def round
    @round ||= Round.find round_id if round_id?
  end

  def round=(r)
    @round        = r
    self.round_id = r.id
    update_teebox if holes.length == 18
  end

  private

  def sum_scorecard
    self.score  = holes.sum :score
    self.length = holes.sum :length
    self.par    = holes.sum :par
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
