class UserPolicy < ApplicationPolicy

  def show?
    record == user
  end

  def update?
    record == user
  end

  class Scope < Scope
    def resolve
      scope.where id: user.id
    end
  end
end
