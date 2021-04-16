class TestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin? or record.teacher == user.profile
  end

  def create?
    user.admin? or record.AC?
  end

  def update?
    user.admin? or record.AC? or record.PP? or record.PT?
  end
end
