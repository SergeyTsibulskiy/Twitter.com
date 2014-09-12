require 'rails_helper'
include Devise::TestHelpers

RSpec.describe Tweet, :type => :model do

  before (:each) do
    @user = build(:user, fullname: 'SergeyTsibulskiy', email: 'c4r0n0s@gmail.com', password: '11111111')
  end

  describe 'Testing model' do
    it 'should save tweet if hi has validation failed (+)' do
      tweet = build(:tweet, tweet: 'Text', user: @user)
      expect(tweet).to be_valid
    end

    it 'should save tweet if hi has validation failed (-)' do
      tweet = build(:tweet, tweet: '', user: @user)
      expect(tweet).not_to be_valid
    end

  end
end