# require 'rspec'
require 'rails_helper'
include Devise::TestHelpers

RSpec.describe MainController, :type => :controller do
  describe 'GET main index' do

    it 'check log in user' do
      u1 = create(:user)
      sign_in u1
      get :index
      expect(subject.current_user).not_to be trust
    end

  end
end