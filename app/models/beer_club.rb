class BeerClub < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  def a_member?(user)
    users.each do |i|
      return true if i.username == user.username
    end
    false
  end

  def to_s
    name
  end
end
