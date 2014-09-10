# require 'rspec'
require 'rails_helper'
include Devise::TestHelpers

RSpec.describe MainController, :type => :controller do
  describe 'GET main index' do

    it 'return http success' do
      get :index
      expect(response.status).to be 200
    end
  end
end