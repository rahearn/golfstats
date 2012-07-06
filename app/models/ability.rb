class Ability
  include CanCan::Ability

  def initialize(user)

    if user.present?
      can [:read, :update], User, id: user.id
      can :create, Course
      can [:read, :create, :update], Round, user_id: user.id
      can [:create, :update, :destroy], CourseNote, user_id: user.id
    end

    can :read, Course
  end

end
