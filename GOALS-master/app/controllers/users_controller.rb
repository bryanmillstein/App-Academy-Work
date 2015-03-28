class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      redirect_to user_url(@user)
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  
    if @user == current_user
      @goals = @user.goals
    else
      @goals = @user.goals.where(privacy: 'Public')
    end
  end

end
