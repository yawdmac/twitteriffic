class EpicenterController < ApplicationController
  before_filter :authenticate_user!
  def feed
  	# TTS-SLIDE28
    # Create and initialize the array
  	@following_tweets = []
    @follower_count = 0

  	# Get all the tweets and users
  	@tweets = Tweet.all
    @users = User.all

  	# Sort and find the ones with the current user
  	@tweets.each do |tweet|
  		current_user.following.each do |f|
  			if tweet.user_id  == f
  				@following_tweets.push(tweet)
  			end
  		end
  	end

    @users.each do |user|
      if user.following.include?(current_user.id)
        @follower_count += 1        
      end
    end

  end

  def show_user
    # Find the user
    # TTS-SLIDE29
    @user = User.find(params[:id])
  end

  def now_following
      # TTS-SLIDE29
      @user = User.find(params[:follow_id])

      current_user.following.push(params[:follow_id].to_i)

      current_user.save

      redirect_to root_path
  end

  def unfollow
    # TTS-SLIDE38
    @user = User.find(params[:unfollow_id])
    
    current_user.following.delete(params[:unfollow_id].to_i)

    current_user.save

    redirect_to root_path

  end

  def js_practice


  end

end
