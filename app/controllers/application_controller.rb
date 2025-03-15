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

  def current_user_admin?
    current_user && current_user.admin?
  end

  def logged_in_or_admin_user?(user)
    current_user_admin? || is_logged_in_user?(user) 
  end

  def require_signin
    unless is_logged_in?
      session[:redirect_url] = request.url
      redirect_to login_path, notice: 'You need to be logged in.'
    end
  end

  def require_admin
    unless current_user_admin?
      redirect_to root_path, alert: 'Unauthorized!'
    end
  end

  helper_method :current_user, 
    :is_logged_in?, 
    :is_logged_in_user?, 
    :current_user_admin?, 
    :logged_in_or_admin_user?
end
