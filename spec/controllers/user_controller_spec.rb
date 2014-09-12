# require 'rspec'
require 'spec_helper'
require 'rails_helper'
include Devise::TestHelpers

RSpec.describe UsersController, :type => :controller do


  before(:each) do
    @u1 = build(:user)
    @u1.save!

    @u2 = build(:user, fullname: 'RostislavOlshevskiy', email: 'RostislavO@gmail.com')
    @u2.save!

    @u3 = build(:user, fullname: 'PetrZhezher', email: 'ZhezherP@gmail.com')
    @u3.save!

    sign_in @u1
  end

  describe 'test user controller' do

    it 'get user profile and showing his tweet' do
      create(:tweet, user: @u1)
      create(:tweet, tweet: 'Test2', user: @u1)
      create(:tweet, user: @u2)

      get :profile, {:user_name => subject.current_user.fullname}
      expect(response.status).to be 200
      tweets = assigns(:tweets)
      expect(tweets.length).not_to be 0
      tweets.each do |tweet|
        expect(tweet.user_id).to be subject.current_user.id
      end
    end

    it 'get user profile and showing his tweet (-)' do
      create(:tweet, user: @u1)
      create(:tweet, user: @u2)

      get :profile, {:user_name => subject.current_user.fullname}
      expect(response.status).to be 200
      tweets = assigns(:tweets)
      expect(tweets.length).not_to be 0
      expect(tweets.first.user_id).to be subject.current_user.id
      expect(tweets.second).to be_nil
    end

    it 'should add Tweet (+)' do
      text = []
      text.push('Test')
      get :add_tweet, {:tweet => text}
      expect(subject.current_user.tweets.first.tweet).to eql(text.first)
    end

    it 'should not add Tweet (-)' do
      text = []
      text.push('')
      get :add_tweet, {:tweet => text}
      expect(subject.current_user.tweets.first).to be_nil
    end

    it 'should del Tweet (+)' do
      create(:tweet, user: subject.current_user)

      get :profile, {:user_name => subject.current_user.fullname}
      tweets = assigns(:tweets)
      expect(tweets.length).to be 1
      delete :del_tweet, {user_id: subject.current_user.id, tweet_id: tweets.first.id}
      expect(response.body).to eql('deleted')
    end

    it 'should not del Tweet (-)' do
      create(:tweet, user: subject.current_user)

      get :profile, {:user_name => subject.current_user.fullname}
      tweets = assigns(:tweets)
      expect(tweets.length).to be 1

      delete :del_tweet, {user_id: subject.current_user.id+1, tweet_id: tweets.first.id}
      expect(response.body).to eql('access is denied')
    end

    it 'should user follow in other user (+)' do
      post :follow, {user: subject.current_user.id, follow: @u2.id}
      expect(response.body).to eql('following')
    end

    it 'should user not follow in himself (-)' do
      post :follow, {user: subject.current_user.id, follow: subject.current_user.id}
      expect(response.body).to eql("You can't be followed for herself`")
    end

    it 'should user unfollow in other user (+)' do
      create(:follower, user: subject.current_user, follow: @u2)

      delete :unfollow, {user_id: subject.current_user.id, follow_id: @u2.id}
      expect(response.body).to eql('deleted')
    end

    it 'should user not unfollow of user whom he dont follower (-)' do
      create(:follower, user: subject.current_user, follow: @u2)

      delete :unfollow, {user_id: subject.current_user.id+1, follow_id: @u2}
      expect(response.body).to eql('access is denied')
    end

    it 'should showing tweets current and following users(+)' do
      tweet_u1 = create(:tweet, user: @u1)
      tweet_u2 = create(:tweet, tweet: 'Test2', user: @u2)
      create(:follower, user: subject.current_user, follow: @u2)

      get :index
      tweets = assigns(:tweets)
      expect(tweets.length).not_to be 0
      expect(tweets.first.tweet).to eql(tweet_u2.tweet)
      expect(tweets.second.tweet).to eql(tweet_u1.tweet)
    end

    it 'should showing tweets current and following users(-)' do
      tweet_u1 = create(:tweet, user: @u1)
      tweet_u2 = create(:tweet, tweet: 'Test2', user: @u2)
      tweet_u3 = create(:tweet, tweet: 'Test3 from Petr', user: @u3)
      create(:follower, user: subject.current_user, follow: @u2)

      get :index
      tweets = assigns(:tweets)
      expect(tweets.length).not_to be 0
      expect(tweets.first.tweet).not_to eql(tweet_u3.tweet)
      expect(tweets.first.tweet).to eql(tweet_u2.tweet)
      expect(tweets.second.tweet).to eql(tweet_u1.tweet)
    end

    it 'should showing tweets after unfollow (+)' do
      tweet_u1 = create(:tweet, user: @u1)
      tweet_u2 = create(:tweet, tweet: 'Test2', user: @u2)
      create(:follower, user: subject.current_user, follow: @u2)

      delete :unfollow, {user_id: subject.current_user, follow_id: @u2.id}
      get :index
      tweets = assigns(:tweets)
      expect(tweets.length).to be 1
      expect(tweets.first.tweet).to eql(tweet_u1.tweet)
    end

    it 'should showing tweets after unfollow (-)' do
      tweet_u1 = create(:tweet, user: @u1)
      tweet_u2 = create(:tweet, tweet: 'Test2', user: @u2)
      create(:follower, user: subject.current_user, follow: @u2)

      delete :unfollow, {user_id: subject.current_user, follow_id: @u2.id}
      get :index
      tweets = assigns(:tweets)
      expect(tweets.length).to be 1
      expect(tweets.first.tweet).to eql(tweet_u1.tweet)
      expect(tweets.second).to be_nil
    end

  end
end