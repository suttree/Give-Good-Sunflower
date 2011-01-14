class HomeController < ApplicationController
  before_filter :require_user, :only => [:unread, :read, :r]
  before_filter :find_next_unread_article, :only => [:unread, :next]

  after_filter :mark_article_as_read, :only => :r

  def r
    @title_prefix = "#{current_user.login} gave good sunflower"
    @articles = current_user.articles.list.paginate(:page => params[:page], :per_page => 1)
    @total_unread = current_user.articles.unread.count

    respond_to do |format|
      format.html do
        if request.xhr?
          render :layout => false
        end
      end
    end
  end

  def unread
    @title_prefix = "#{current_user.login} gave good sunflower"

    respond_to do |format|
      format.html do
        if request.xhr?
          render :layout => false
        end
      end
    end
  end

  def next
    render :action => :unread, :layout => request.xhr?
  end

  def archives
    @title_prefix = "#{current_user.login} gave good sunflower / archives"
    @articles = current_user.articles.read.paginate(:page => params[:page], :per_page => 1)
  end

  def read
    @article = Article.find(params[:id])
  end

  protected
  def find_next_unread_article
    redirect_to '/' and return if current_user.articles.unread.count == 0

    @article = current_user.articles.unread.first
    @article.mark_as_read
    @total_unread = current_user.articles.unread.count
  end

  def mark_article_as_read
    @articles.first.mark_as_read unless @articles.empty? || @articles.first.read?
  end
end
