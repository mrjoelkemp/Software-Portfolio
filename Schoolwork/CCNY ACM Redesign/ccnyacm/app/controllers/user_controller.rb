class UserController < ApplicationController
  before_filter :admin_required, :only => :destroy
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @user_pages, @users = paginate :users, :per_page => 10
  end

  def show
    @user = User.find(params[:id])
	
  end
  
  def showProfilePic
	send_data @user.picture_data, :filename => @user.filename, :type => @user.filetype, :disposition => "inline"
  end
  
 def showImage
     @user = User.find(params[:id])
     @image = @user.picture_data
     send_data(@image, :type     => @user.filetype,
                        :filename => @user.filename,
                        :disposition => 'inline')
  end 

  def new
    @user = User.new
  end
  
  def create
	require 'cgi'
	if ! @params['user']['tmp_file'].blank?
		@params['user']['filename'] = @params['user']['tmp_file'].original_filename
		@params['user']['filetype'] = @params['user']['tmp_file'].content_type
		@params['user']['filesize'] = @params['user']['tmp_file'].length
		@params['user']['picture_data'] = @params['user']['tmp_file'].read
	end
	@params['user'].delete('tmp_file')
	@user = User.new(params[:user])
    if @user.save(@params["user"])
      flash[:notice] = 'User was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
	require 'cgi'
	if ! @params['user']['tmp_file'].blank?
		@params['user']['filename'] = @params['user']['tmp_file'].original_filename
		@params['user']['filetype'] = @params['user']['tmp_file'].content_type
		@params['user']['filesize'] = @params['user']['tmp_file'].length
		@params['user']['picture_data'] = @params['user']['tmp_file'].read
	end
	@params['user'].delete('tmp_file')
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def postMessage
    @message = Message.new(params[:message])
    @message.sent_on = Time.now
    @message.time = Time.now
    @message.from = User.find(session[:user_id]).firstName << " " << User.find(session[:user_id]).lastName
    @message.to = User.find(params[:id]).userName
    @message.subject = "None"
    @message.isRead = false
    @message.user_id = params[:id]
    if @message.save
      flash[:notice] = 'Message successfully posted'
      redirect_to :action => 'show', :id => params[:id]
    else
      flash[:notice] = 'Could Not Post Message'
    end
  end
  
  def destroyMessage
    Message.find(params[:messageId]).destroy
    redirect_to :action => 'show', :id => params[:userId]
  end
end
