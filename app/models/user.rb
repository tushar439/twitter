class User < ActiveRecord::Base
	has_many :tweets
  	
  def follower
    User.find(FollowerMapping.where(followee_id: id).pluck(:follower_id))
  end

  def followee
    User.find(FollowerMapping.where(follower_id: id).pluck(:followee_id))
  end

  def relation followee_id, follower_id
    follower = FollowerMapping.where(follower_id: follower_id , followee_id: followee_id).first
    if follower
      return "loyalty"
    else
      return "local_offer"
    end
  end

end