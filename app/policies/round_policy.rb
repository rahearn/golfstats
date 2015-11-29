class RoundPolicy < ApplicationPolicy

  def show?
    record.user == user
  end

  def create?
    record.user == user
  end

  def update?
    record.user == user
  end

  class Scope < Scope
    def resolve
      if user
        scope.where user_id: user.id
      else
        scope.none
      end
    end
  end
end
