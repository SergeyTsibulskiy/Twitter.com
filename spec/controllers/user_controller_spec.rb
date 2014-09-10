# require 'rspec'
require 'spec_helper'
require 'rails_helper'
include Devise::TestHelpers

RSpec.describe UsersController, :type => :controller do

  before(:each) do

  end

  describe 'GET user index' do

    it 'return http success' do
      get :profile, {:fullname => 'SergeyTsibulskiy'}
      # get :index
      expect(response.status).to be 200
      # true.should == false
    end
  end
end