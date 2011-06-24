class EventController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @event_pages, @events = paginate :events, :per_page => 5
  end

  def show
    @event = Event.find(params[:id])
  end
  
  def showImage
     @event = Event.find(params[:id])
     @image = @event.image_data
     send_data(@image, :type     => @event.filetype,
                        :filename => @event.filename,
                        :disposition => 'inline')
  end 

  def new
    @event = Event.new
  end

  def create
	require 'cgi'
	if ! @params['event']['img_file'].blank?
		@params['event']['filename'] = @params['event']['img_file'].original_filename
		@params['event']['filetype'] = @params['event']['img_file'].content_type
		@params['event']['filesize'] = @params['event']['img_file'].length
		@params['event']['image_data'] = @params['event']['img_file'].read
	end
	@params['event'].delete('img_file')
	@event = Event.new(params[:event])
    if @event.save(@params["event"])
      flash[:notice] = 'event was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
	require 'cgi'
	if ! @params['event']['img_file'].blank?
		@params['event']['filename'] = @params['event']['img_file'].original_filename
		@params['event']['filetype'] = @params['event']['img_file'].content_type
		@params['event']['filesize'] = @params['event']['img_file'].length
		@params['event']['image_data'] = @params['event']['img_file'].read
	end
	@params['event'].delete('img_file')
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      redirect_to :action => 'show', :id => @event
    else
      render :action => 'edit'
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
