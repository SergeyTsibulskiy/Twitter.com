class UsersController < ApplicationController
  protect_from_forgery

  def profile
    @user = User.find_by_fullname(params[:user_name])
    @tweets = @user.tweets
    @following_user = Follower.where(:user_id => current_user.id).all
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :fullname) }
  # end

  def index
    @current_user = User.find_by_id(current_user.id)
    my_tweets = current_user.tweets

    @following_user = Follower.where(:user_id => @current_user.id).all

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
    current_user_id = params[:user_id]
    tweet_id = params[:tweet_id]

    current_tweet = Tweet.find_by_id(tweet_id)

    if current_tweet.user_id == current_user_id.to_f
      current_tweet.destroy!
      render json: 'deleted'
    else
      render json: 'access is denied'
    end

  end

  def follow
    follow = Follower.new
    follow.user = User.find_by_id(params[:user])
    follow.follow = User.find_by_id(params[:follow])

    if follow.follow.id != follow.user.id
      if (!Follower.exists?(:user_id => follow.user, :follow_id => follow.follow))
        follow.save!
        render json: 'following'
      else
        render json: 'exist'
      end
    else
      render json: "You can't be followed for herself`"
    end

    def unfollow
      user_id = params[:user_id]
      follow_id = params[:follow_id]

      current_follow = Follower.where(:user_id => user_id, :follow_id => follow_id).first
      current_follow.destroy!

      render json: 'deleted'
    end

  end
end
