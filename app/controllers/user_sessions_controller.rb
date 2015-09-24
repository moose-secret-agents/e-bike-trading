class UserSessionsController < ApplicationController
  def new

  end

  def create
    if @user = login(params[:user_session][:email], params[:user_session][:password])
      redirect_back_or_to(:users, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'Logged out!')
  end
end