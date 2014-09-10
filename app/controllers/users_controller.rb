class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:follow, :unfollow, :del_tweet]
  protect_from_forgery

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def profile
    @user = User.find_by_fullname(params[:user_name])
    if(@user.blank?)
      render_404
    else
      @tweets = @user.tweets.order(:created_at).reverse_order
      @following_user = Follower.where(:user_id => current_user.id).all
      @followers_user = Follower.where(:follow_id => current_user.id)
      @users = User.order('RAND()').limit(3)
    end
  end

  def index
    @current_user = User.find_by_id(current_user.id)
    my_tweets = current_user.tweets
    @count = my_tweets.length

    @users = User.order('RAND()').limit(3)

    @following_user = Follower.where(:user_id => current_user.id).all
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
