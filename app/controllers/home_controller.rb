class HomeController < ApplicationController
  before_filter :require_user, :only => :unread
end
