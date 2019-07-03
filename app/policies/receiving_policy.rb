class ReceivingPolicy < ApplicationPolicy
  def create?
    user.admin?
  end
end
