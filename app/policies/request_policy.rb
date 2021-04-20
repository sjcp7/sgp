class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all if user.admin?
    end
  end

  def index?
    user.admin?
  end

  def create?
    true
  end

  def show
    user.admin?
  end
end
