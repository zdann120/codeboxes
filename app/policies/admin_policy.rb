class AdminPolicy < ApplicationPolicy
  def show?
    if user
      user.admin
    else
      false
    end
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
