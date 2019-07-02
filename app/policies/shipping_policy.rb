class ShippingPolicy < ApplicationPolicy
  def create?
    user.admin?
  end
  def update?
    user.admin?
  end
  def resend?
    user.admin?
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
