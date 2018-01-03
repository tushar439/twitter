class Tweet < ActiveRecord::Base
  belongs_to :user

  def emotion tweet_id
    like = Like.where(tweet_id: tweet_id).first
    if like
      return "favorite"
    else
      return "favorite_border"
    end
  end

end