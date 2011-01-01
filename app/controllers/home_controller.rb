class HomeController < ApplicationController
  before_filter :require_user, :only => :unread
  after_filter :mark_as_read, :only => :unread

  def unread
    @title_prefix = "#{current_user.login} gave good sunflower"
    @articles = current_user.articles.unread.paginate(:page => params[:page], :per_page => 1)
  end

  def archives
    @title_prefix = "#{current_user.login} gave good sunflower / archives"
    @articles = current_user.articles.paginate(:page => params[:page], :per_page => 1)
  end

  def read
    @article = Article.find(params[:id])
  end

  protected
  def mark_as_read
    @articles.collect{ |article| article.mark_as_read }
  end
end
