class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end

  def render_400
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/400", :layout => false, :status => 400 }
      format.js { head :bad_request }
      format.xml { head :bad_request }
      format.any { head :bad_request }
    end
  end
end
