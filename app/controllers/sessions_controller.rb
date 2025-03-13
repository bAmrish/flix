class SessionsController < ApplicationController
  
  def new    
  end

  def create
    username_or_email = params[:username_or_email]
    password = params[:password]
    @user = User.find_by(username: username_or_email) || User.find_by(email: username_or_email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome back #{@user.name}!"
    else
      flash.now[:alert] = 'Invalid username or password!'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    
  end
end
