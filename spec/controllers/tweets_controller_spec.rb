require 'rails_helper'
include Devise::TestHelpers

RSpec.describe TweetsController, :type => :controller do

  before(:each) do
    @u1 = build(:user)
    @u1.save!

    sign_in @u1
  end

  describe 'test user controller' do

    it 'should add Tweet (+)' do
      text = {'tweet' => 'Test'}
      put :create, {:tweet => text}
      expect(subject.current_user.tweets.first.tweet).to eql(text['tweet'])
    end

    it 'should not add Tweet (-)' do
      text = {'tweet' => ''}
      put :create, {:tweet => text}
      expect(subject.current_user.tweets.first).to be_nil
    end

    it 'should del Tweet (+)' do
      tweet = create(:tweet, user: subject.current_user)

      delete :destroy, {id: tweet.id}
      expect(response.status).to be 302
    end

    it 'should not del Tweet (-)' do
      tweet = create(:tweet, user: subject.current_user)

      delete :destroy, {id: tweet.id+1}
      expect(response.status).to be 400
    end

  end
end