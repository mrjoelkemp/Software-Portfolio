# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_ccnyacm_session_id'


	before_filter :fetch_logged_in_user
	protected
		def fetch_logged_in_user
			return if session[:user_id].blank?
			@current_user = User.find_by_id(session[:user_id])
		end
	
	def logged_in?
		! @current_user.blank?
	end
	helper_method :logged_in?
	
	def admin_logged_in?
		return (logged_in? && @current_user.isAdmin)
	end
	helper_method :admin_logged_in?
	
	def belongs_to_user?
		return ( session[:user_id] == @user.id )
	end
	helper_method :belongs_to_user?

	def login_required
		return true if logged_in?
		session[:return_to] = request.request_uri
		redirect_to :controller => "/account", :action => "login" and
		return false
	end
	
	def admin_required
		#@current_user = User.find_by_id(session[:user_id])
	    return true if @current_user.isAdmin 
		flash[:notice] = "You can not edit this section"
		redirect_to :action => 'list'
		return false
	end
	
	# for allowing users to edit their own information but not others
	def user_required
		return true if true
	end

end
