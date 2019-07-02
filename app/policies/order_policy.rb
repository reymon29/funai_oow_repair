class OrderPolicy < ApplicationPolicy

  def create?
   user.admin?
  end

  def show?
    return true
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
