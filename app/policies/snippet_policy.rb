class SnippetPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    if record.box.privacy_level == "locked"
      user == record.box.user
    elsif record.box.privacy_level == "unlisted"
      true
    elsif record.box.privacy_level == "open"
      true
    end
  end

  def new?
    create?
  end

  def create?
    user == record.box.user
  end

  def edit?
    update?
  end

  def update?
    user == record.box.user
  end

  def destroy?
    user == record.box.user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
