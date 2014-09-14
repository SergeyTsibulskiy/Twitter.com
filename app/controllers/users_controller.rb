class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:follow, :unfollow]
  protect_from_forgery


  def profile
    @user = User.find_by_fullname(params[:user_name])
    if (@user.blank?)
      render_404
    else
      @tweets = @user.tweets.order(:created_at).reverse_order
      @following_user = Follower.where(:user_id => @user.id)
      @followers_user = Follower.where(:follow_id => @user.id)
      @users = User.order('RAND()').limit(3)
    end
  end

  def index
    my_tweets = current_user.tweets
    @count = my_tweets.length
    @users = User.order('RAND()').limit(3)

    @following_user = Follower.where(:user_id => current_user.id)
    @followers_user = Follower.where(:follow_id => current_user.id)

    @tweets = my_tweets
    if @following_user.any?
      @following_user.each do |user|
        following_tweets = (User.find_by_id(user.follow_id)).tweets
        @tweets += following_tweets
      end
    end

    @tweets = @tweets.sort_by { |obj| obj.created_at }
    @tweets.reverse!

    render 'users/index'
  end

  def add_tweet
    tweet = Tweet.new
    tweet.user = User.find_by_id(current_user.id)
    tweet.tweet = params[:tweet][0].html_safe

    if tweet.valid?
      tweet.save!
    end

    redirect_to('/home')
  end

  def del_tweet
    tweet_id = params[:tweet_id]
    current_tweet = Tweet.find_by_id(tweet_id)
    if !current_tweet.nil? and current_tweet.user_id == current_user.id
    current_tweet.destroy!
      render json: 'deleted'
    else
      render json: 'access is denied'
    end
  end

  def follow
      follow = Follower.new
      follow.user = User.find_by_id(current_user.id)
      follow.follow = User.find_by_id(params[:follow])
      if follow.follow.id != follow.user.id
        if !Follower.exists?(:user_id => follow.user, :follow_id => follow.follow)
          follow.save!
          render json: 'following'
        else
          render json: 'exist'
        end
      else
        render json: "You can't be followed for herself`"
      end
  end

  def unfollow
      user_id = current_user.id
      follow_id = params[:follow_id]

      if (current_follow = Follower.where(:user_id => user_id, :follow_id => follow_id).first).nil?
        render json: 'error'
      else
        current_follow.destroy!
        render json: 'deleted'
      end
  end

end
