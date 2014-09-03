class UsersController < ApplicationController
  protect_from_forgery

  def profile
    @user = User.find_by_fullname(params[:user_name])
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :fullname) }
  # end

  def index
    @current_user = User.find_by_id(current_user.id)
    @tweets = @current_user.tweets

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
    data = params[:params]

    current_tweet = Tweet.find_by_id(data)
    current_tweet.destroy!

    render json: 'deleted'
  end

  def follow
    follow = Follower.new
    follow.user = User.find_by_id(params[:user])
    follow.follow = User.find_by_id(params[:follow])

    if (!Follower.exists?(:user_id => follow.user, :follow_id => follow.follow))
      follow.save!
      render json: 'following'
    else
      render json: 'exist'
    end

  end
end
