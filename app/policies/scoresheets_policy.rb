class ScoresheetsPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.admin? or record.batch_director == user.profile
  end
end
