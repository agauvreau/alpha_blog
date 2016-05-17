class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #those methods are available to all controller but not to the html.erb files view (by default)
  #so helper method will let rails know how to use these 2 methods
  
  helper_method :current_user, :logged_in?
  
  
  def current_user
    #@current_user ||= (if not, if not already) makes sure you don't continuously check the database eachtime you use current_user, creates a instance variable @current_user
    
    # we are saying here: return(produce) this user id if he/she is logged, allows me to get their name email etc.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    
  end
  
  def logged_in?
    # !! converts anything in a boolean (true/false) value
    !!current_user
    
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
    
  end
  
end
