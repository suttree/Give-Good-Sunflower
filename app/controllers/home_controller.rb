class HomeController < ApplicationController
  before_filter :require_user, :only => :unread

  def unread
    @title_prefix = "#{current_user.login} gave good sunflower"
    @articles = current_user.articles.paginate :page => params[:page], :per_page => 1
  end
end
