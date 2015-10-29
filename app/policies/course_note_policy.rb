class CourseNotePolicy < ApplicationPolicy

  def create?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
