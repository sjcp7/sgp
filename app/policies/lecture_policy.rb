class LecturePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.teacher?
        teacher = user.profile
        scope.where(teacher: teacher).or(scope.where(batch: [teacher.managed_batches]))
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
