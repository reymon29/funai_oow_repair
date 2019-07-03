class RepairPolicy < ApplicationPolicy
  def create?
    user.admin?
  end
end
