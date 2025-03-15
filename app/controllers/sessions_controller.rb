class SessionsController < ApplicationController
  
  def new    
  end

  def create
    username_or_email = params[:username_or_email]
    password = params[:password]
    @user = User.find_by(username: username_or_email) || User.find_by(email: username_or_email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      redirect_url = session[:redirect_url] || @user
      redirect_to redirect_url, notice: "Welcome back #{@user.name}!"
      session.delete(:redirect_url)
    else
      flash.now[:alert] = 'Invalid username or password!'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to movies_path, status: :see_other, notice: 'You are successfully logged out!'
  end
end
