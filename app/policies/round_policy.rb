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
      scope.where user_id: user.id
    end
  end
end
