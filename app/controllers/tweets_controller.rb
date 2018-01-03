class TweetsController < ApplicationController
  def tweet
  	content = params["content"]
  	user_id = session[:user_id].to_i
  	tweet = Tweet.new
  	tweet.content = content
  	tweet.user_id = user_id
  	tweet.save
  	return redirect_to '/users/profile'
  end

  def feel
    tweet_id = params["tweet_id"]
    user_id = params["user_id"]
    like = Like.where(tweet_id: tweet_id).first
    # puts "=============================================#{user_id}"
    # puts "=============================================#{session[:user_id]}"
    # puts "=============================================#{tweet_id}"
    # puts "=============================================#{like.user_id}"
    # puts "=============================================#{like.tweet_id}"
    if like
      like.destroy
    else
      like = Like.new
      like.user_id = user_id
      like.tweet_id = tweet_id
      like.save
    end
    return redirect_to '/users/profile'
  end

  def delete
    tweet_id = params["tweet_id"]
    tweet = Tweet.where(id: tweet_id).first
    tweet.delete
    like = Like.where(tweet_id: tweet_id).first
    if like
      like.destroy
    end
    return redirect_to "/users/profile"
  end
end
