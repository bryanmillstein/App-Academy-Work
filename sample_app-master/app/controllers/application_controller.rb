class ApplicationController < ActionController::Base
    

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  
  # ... resource config ...
  

   def permitted_params
       params.permit user: [:username, :email, :password, :password_confirmation]
   end
 end



