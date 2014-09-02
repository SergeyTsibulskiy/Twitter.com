class UsersController < ApplicationController
  def profile
    @current_user = current_user
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :fullname) }
  # end

  def index

  end

  def follow
    curent_user = current_user.id
  end
end
