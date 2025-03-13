class SessionsController < ApplicationController
  
  def new    
  end

  def create
    username = params[:username]
    password = params[:password]
    @user = User.find_by(username: username)
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
