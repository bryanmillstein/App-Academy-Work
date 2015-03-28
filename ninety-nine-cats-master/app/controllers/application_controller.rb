class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user


  def current_user
    return nil unless session[:session_token]
    @current_user ||= SessionToken
      .find_by(session_token: session[:session_token]).user
  end

  def login_user!
    token = SessionToken.new(user_id: @user.id)
    # @user.reset_session_token!
    token.device = session[:device]
    token.browser = session[:browser]
    token.ip = session[:ip]
    
    token.save
    session[:session_token] = token.session_token
    redirect_to cats_url
  end

end
