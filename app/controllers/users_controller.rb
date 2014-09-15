class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:follow, :unfollow]
  protect_from_forgery


  def profile
    @user = User.find_by_fullname(params[:user_name])
    if (@user.blank?)
      render_404
    else
      @tweets = @user.tweets.order(:created_at).reverse_order
      @following_users = Follower.where(:user_id => current_user.id)
      @followers_user = Follower.where(:follow_id => current_user.id)
      @users = User.randomly.limit(3)
    end
  end

  def index
    @tweet = Tweet.new
    my_tweets = current_user.tweets
    @count = my_tweets.length
    @users = User.randomly.limit(3)

    @following_users = current_user.followers
    @followers_user = Follower.where(:follow_id => current_user.id)


    @tweets = my_tweets
    if @following_users.any?
      @following_users.each do |user|
        following_tweets = (User.find_by_id(user.follow_id)).tweets
        @tweets += following_tweets
      end
    end

    @tweets = @tweets.sort_by(&:created_at)
    @tweets.reverse!

    render 'users/index'
  end

  def follow
      follow = Follower.new
      follow.user = User.find_by_id(current_user.id)
      follow.follow = User.find_by_id(params[:follow])
      if follow.follow.id != follow.user.id
        if !Follower.exists?(user_id: follow.user, follow_id: follow.follow)
          follow.save!
          render plain: 'following'
        else
          render plain: 'exist'
        end
      else
        render plain: "You can't be followed for herself`"
      end
  end

  def unfollow
      user_id = current_user.id
      follow_id = params[:follow_id]

      if (current_follow = Follower.where(user_id: user_id, follow_id: follow_id).first).nil?
        render plain: 'error'
      else
        current_follow.destroy!
        render plain: 'deleted'
      end
  end

end
