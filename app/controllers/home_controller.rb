class HomeController < ApplicationController
  before_filter :require_user, :only => :unread

  def unread
    @articles = current_user.articles.paginate :page => params[:page], :per_page => 1
  end
end
