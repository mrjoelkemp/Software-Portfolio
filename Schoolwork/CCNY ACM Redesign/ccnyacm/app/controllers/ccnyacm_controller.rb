class CcnyacmController < ApplicationController
  def index
    listArticlesAndEvents
    render :action => 'listArticlesAndEvents'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def listArticlesAndEvents
	@article_pages, @articles = paginate :articles, :per_page => 5
	@event_pages, @events = paginate :events, :per_page => 5
  end

  def show
    @user = User.find(params[:id])
  end
  
  def rss
	@events = Event.find :all, :limit => 5, :order => 'id DESC'
	@articles = Article.find :all, :limit => 5, :order => 'id DESC'
	render_without_layout
	@headers["Content-Type"] = "application/xml; charset=utf-8"
  end
  
end
