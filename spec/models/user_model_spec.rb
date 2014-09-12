require 'rails_helper'
include Devise::TestHelpers

RSpec.describe User, :type => :model do

  describe 'Testing user model' do

    it 'should save user if hi has validation failed (+)' do
      @u1 = build(:user, fullname: 'SergeyTsibulskiy', email: 'c4r0n0s@gmail.com', password: '11111111')
      expect(@u1).to be_valid
    end

    it 'should save user if hi has validation failed (-)' do
      @u1 = build(:user, fullname: 'SergeyTsibulskiy', email: 'c4r0n0s@gmail.com', password: '11')
      expect(@u1).not_to be_valid
    end
  end
end

