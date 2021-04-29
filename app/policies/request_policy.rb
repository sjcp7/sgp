class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.teacher? && user.profile.managed_batches.any?
        scope.find_by_batches(user.profile.managed_batches)
      end        
    end
  end

  def index?
    user.admin? or user.profile.managed_batches.any?
  end

  def create?
    true
  end

  def show?
    user.admin? or record.batch_director == user.profile
  end
end
