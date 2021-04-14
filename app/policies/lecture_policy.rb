class LecturePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.teacher?
        scope.where(teacher: user.profile)
      end
    end
  end

  def index?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy
    user.admin?
  end
end
