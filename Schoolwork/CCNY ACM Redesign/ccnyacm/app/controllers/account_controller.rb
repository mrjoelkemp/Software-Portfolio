class AccountController < ApplicationController

  
	def login
		if request.post?
			@current_user = User.find_by_userName_and_password( params[:login], params[:password])
     
		  if @current_user.nil?
				redirect_to :controller => 'ccnyacm'
				flash[:notice] = "Username and Password not found"
		  else
             session[:user_id] = @current_user.id
			 if session[:return_to].blank?
			    redirect_to :controller => 'ccnyacm'  
			 else 
			    redirect_to session[:return_to]
				session[:return_to] = nil
             end
		  end
	    end
	end
  

  def logout
		session[:user_id] = @current_user = nil
		redirect_to :controller => 'ccnyacm'
		flash[:notice] = "You have been logged out"
	end
end
