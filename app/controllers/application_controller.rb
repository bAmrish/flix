class ApplicationController < ActionController::Base

private
  def current_user
    @current_user ||= User.find(session[:user_id]) if is_logged_in?
  end

  def is_logged_in?
    session[:user_id].present?
  end

  def is_logged_in_user? (user)
    return current_user == user
  end

  helper_method :current_user, :is_logged_in?, :is_logged_in_user?

  def require_signin
    unless is_logged_in?
      session[:redirect_url] = request.url
      redirect_to login_path, notice: 'You need to be logged in.'
    end
  end
end
