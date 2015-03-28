class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name],
                                    params[:user][:password])

    if @user
      login_user!
    else
      @user = User.new
      render :new
    end
  end

  def destroy
    # current_user.reset_session_token!
    SessionToken.find_by(session_token: session[:session_token]).destroy
    session[:session_token] = nil

    redirect_to cats_url
  end

  private

  def redirect_if_logged_in
    redirect_to cats_url if current_user
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
