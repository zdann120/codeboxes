class BoxPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    if record.privacy_level == "locked"
      user == record.user ? true : false
    elsif record.privacy_level == "unlisted"
      true
    elsif record.privacy_level == "open"
      true
    end
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    user == record.user
  end

  def destroy?
    user == record.user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
