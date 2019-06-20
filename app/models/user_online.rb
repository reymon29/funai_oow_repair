class UserOnline < ApplicationRecord
  belongs_to :user

  def self.useronline?(user)
    user = user
    location = UserOnline.find_by(user: user)
    if location.nil?
      return false
    else
      return true
    end
  end

  def self.my_online_users
    users = self.all
  end
end
