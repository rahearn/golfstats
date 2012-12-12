puts "Loading User"

class User < ActiveRecord::Base

  attr_protected :openid_uid

  devise :omniauthable, :rememberable, :trackable

  has_many :rounds, dependent: :destroy
  has_many :course_notes, dependent: :destroy

  validates_presence_of :openid_uid
  validates_presence_of :openid_provider
  validates_uniqueness_of :openid_uid, scope: :openid_provider, if: :openid_uid_changed?

  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  validates_format_of :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?

  validates_inclusion_of :gender, in: %w(male female)

  validates_numericality_of :handicap,
    allow_nil: true,
    less_than_or_equal_to: :maximum_handicap


  def handicap
    self[:handicap] || maximum_handicap
  end

  private

  def maximum_handicap
    gender == 'male' ? 36.4 : 40.4
  end
end
