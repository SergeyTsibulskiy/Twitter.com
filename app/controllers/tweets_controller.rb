class TweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = Tweet.new
    @tweet.user = User.find_by_id(current_user.id)
    @tweet.tweet = params[:tweet][:tweet]

    if @tweet.valid?
      @tweet.save!
      redirect_to :back
    else
      render_400
    end
  end

  def destroy
    tweet_id = params[:id]
    current_tweet = Tweet.find_by_id(tweet_id)
    if !current_tweet.nil? and current_tweet.user_id == current_user.id
      current_tweet.destroy!
      redirect_to home_path
    else
      render_400
    end
  end
end