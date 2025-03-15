class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.find(session[:user_id]) if is_logged_in?
  end

  def is_logged_in?
    session[:user_id].present?
  end

  helper_method :current_user, :is_logged_in?

  def require_signin
    unless is_logged_in?
      redirect_to login_path, notice: 'You need to be logged in.'
    end
  end
end
