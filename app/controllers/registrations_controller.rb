class RegistrationsController < Devise::RegistrationsController

  private
  def sign_up_params
    params.require(:user).permit(:fullname, :email, :password)
  end

  def account_update_params
    params.require(:user).permit(:fullname, :email, :password, :current_password, :avatar)
  end

  def user_params
    params.require(:user).permit(:avatar)
  end
end