class UsersController < ApplicationController
  
  def index
    if session[:user_id].nil?
		  return redirect_to '/users/signin'
  	end
    return redirect_to '/users/profile'
  end

  def signup
  end

  def signin
  end

  def find
    @user = User.find(session[:user_id])
    @avatars = {:Boy => "boy.png", :Boy_1 => "boy-1.png", :Girl => "girl.png", :Girl_1 => "girl-1.png", :Man => "man.png", :Man_1 => "man-1.png", :Man_2 => "man-2.png", :Man_3 => "man-3.png", :Man_4 => "man-4.png", :User => "user.png", :People => "people.png", :Profession => "profession.png"}
    (1..11).each do |i|
      key = "User_" + i.to_s
      value = "user-" + i.to_s + ".png"
      @avatars[key.to_sym] = value
    end
    (1..23).each do |i|
      key = "People_" + i.to_s
      value = "people-" + i.to_s + ".png"
      @avatars[key.to_sym] = value
    end
    (1..49).each do |i|
      key = "Profession_" + i.to_s
      value = "profession-" + i.to_s + ".png"
      @avatars[key.to_sym] = value
    end
    render :layout => "profile.html.erb"
  end

  def profile
    @user = User.find(session[:user_id])
    followers = @user.follower
    
    @avatars = {:Boy => "boy.png", :Boy_1 => "boy-1.png", :Girl => "girl.png", :Girl_1 => "girl-1.png", :Man => "man.png", :Man_1 => "man-1.png", :Man_2 => "man-2.png", :Man_3 => "man-3.png", :Man_4 => "man-4.png", :User => "user.png", :People => "people.png", :Profession => "profession.png"}
    (1..11).each do |i|
      key = "User_" + i.to_s
      value = "user-" + i.to_s + ".png"
      @avatars[key.to_sym] = value
    end
    (1..23).each do |i|
      key = "People_" + i.to_s
      value = "people-" + i.to_s + ".png"
      @avatars[key.to_sym] = value
    end
    (1..49).each do |i|
      key = "Profession_" + i.to_s
      value = "profession-" + i.to_s + ".png"
      @avatars[key.to_sym] = value
    end

    @tweets = []
    followers.each do |follower|
      follower.tweets.each do |tweet|
        @tweets << tweet
      end
    end
    @user.tweets.each do |tweet|
      @tweets << tweet
    end
    @tweets = @tweets.reject(&:blank?)
    render :layout => "profile.html.erb"
  end

  def logout
    session[:user_id] = nil
    return redirect_to '/users/index'
  end

  def signup_submit
  	pass = params["pass"]
  	email = params["email"]
  	name = params["name"]
  	user = User.where(email: email).first

  	if user
  		return redirect_to '/users/signup'
  	else
  		user = User.new
  		user.name = name
  		user.email = email
  		user.pass = pass
      user.avatar = "avatar/man-1.png"
      user.status = "I love using Litter."
  		user.save
  		session[:user_id] = user.id
  		return redirect_to '/users/profile'
  	end
  end

  def signin_submit
    pass = params["pass"]
    email = params["email"]
    user = User.where(email: email).first
    # user = User.find_by_email(email)
    if user
      if user.pass == pass
        session[:user_id] = user.id
        return redirect_to '/users/profile'
      else
        return redirect_to '/users/signin'
      end
    else
      return redirect_to '/users/signup'
    end
  end

  def avatar
    user = User.find(session[:user_id])
    user.avatar = "avatar/" + params["avatar"]
    user.save
    return redirect_to '/users/profile'
  end

  def status
    user = User.find(session[:user_id])
    user.status = params["status"]
    user.save
    return redirect_to '/users/profile'
  end

  def followermapping
    followee_id = params["followee_id"]
    follower_id = params["follower_id"]
    follower = FollowerMapping.where(follower_id: follower_id , followee_id: followee_id).first
    if follower
      follower.destroy
    else
      follower = FollowerMapping.new
      follower.follower_id = follower_id
      follower.followee_id = followee_id
      follower.save
    end
    return redirect_to '/users/find'
  end

end