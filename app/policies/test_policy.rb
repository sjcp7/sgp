class TestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin? or user_owns_test?
  end

  def create?
    user.admin? or record.AC?
  end

  def update?
    user.admin? or batch_director? or (!record.locked? && (user_owns_test? && allowed_tests?))
  end

  private

  def user_owns_test?
    record.teacher == user.profile
  end

  def batch_director?
    record.batch.batch_director == user.profile
  end

  def allowed_tests?
    record.AC? || record.PP? || record.PT? || record.EX?
  end
end
