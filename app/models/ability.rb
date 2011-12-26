class Ability
  include CanCan::Ability

  def initialize(user)

    if user.present?
      can [:create], Course
      can [:read, :create], Round, :user_id => user.id
      can [:read], User, :id => user.id
    end

    can [:read], Course
  end

end
