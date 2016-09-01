class SnippetPolicy < ApplicationPolicy
  def show?
    if record.box.privacy_level == "locked"
      user == record.box.user
    elsif record.box.privacy_level == "unlisted"
      true
    elsif record.box.privacy_level == "open"
      true
    end
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
