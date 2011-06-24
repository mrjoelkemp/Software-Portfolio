class ArticleController < ApplicationController
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @article_pages, @articles = paginate :articles, :per_page => 5
  end

  def show
    @article = Article.find(params[:id])
  end
  
  def showImage
     @article = Article.find(params[:id])
     @image = @article.image_data
     send_data(@image, :type     => @article.filetype,
                        :filename => @article.filename,
                        :disposition => 'inline')
  end 
  

  def new
    @article = Article.new
  end
  
 def create
	require 'cgi'
	if ! @params['article']['img_file'].blank?
		@params['article']['filename'] = @params['article']['img_file'].original_filename
		@params['article']['filetype'] = @params['article']['img_file'].content_type
		@params['article']['filesize'] = @params['article']['img_file'].length
		@params['article']['image_data'] = @params['article']['img_file'].read
	end
	@params['article'].delete('img_file')
	@article = Article.new(params[:article])
    if @article.save(@params["article"])
      flash[:notice] = 'Article was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
	require 'cgi'
	if ! @params['article']['img_file'].blank?
		@params['article']['filename'] = @params['article']['img_file'].original_filename
		@params['article']['filetype'] = @params['article']['img_file'].content_type
		@params['article']['filesize'] = @params['article']['img_file'].length
		@params['article']['image_data'] = @params['article']['img_file'].read
	end
	@params['article'].delete('img_file')
    if @article.update_attributes(params[:article])
      flash[:notice] = 'Article was successfully updated.'
      redirect_to :action => 'show', :id => @article
    else
      render :action => 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

end
