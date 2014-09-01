class UsersController < ApplicationController
  def profile
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :fullname) }
  end
end
