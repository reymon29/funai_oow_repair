class ImagePolicy < ApplicationPolicy
  def create?
    user.admin?
  end
end
