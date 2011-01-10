class HomeController < ApplicationController
  before_filter :require_user, :only => :unread
  before_filter :find_next_unread_article, :only => [:unread, :next]

  def unread
    @title_prefix = "#{current_user.login} gave good sunflower"
  end

  def next
    render :action => :unread
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
    @article = current_user.articles.unread.first
    @article.mark_as_read
    @total_unread = current_user.articles.unread.count
  end
end
