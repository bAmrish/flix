class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :set_user_from_request, only: [:edit, :update, :destroy]
  before_action :require_logged_in_user, only: [:edit, :update]
  before_action :require_logged_in_or_admin_user, only: [:destroy]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Thanks for signing up!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Account updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @user.destroy
    session.delete(:user_id) unless current_user_admin?
    redirect_to movies_url, alert: 'Account Deleted Successfully!'
  end
  
private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :username)
  end

  def require_logged_in_user
    redirect_to movies_url, alert: "Unauthorized!" unless is_logged_in_user?(@user)
  end

  def require_logged_in_or_admin_user
    redirect_to movies_url, alert: "Unauthorized!" \
      unless logged_in_or_admin_user?(@user)
  end

  def set_user_from_request
    @user = User.find(params[:id])  
  end
end
