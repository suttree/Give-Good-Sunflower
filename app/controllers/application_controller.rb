class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :setup_twitter

  protected
  def setup_twitter
    if current_user
      Twitter.configure do |config|
        config.consumer_key = Omnisocial.service_configs[:twitter].app_key
        config.consumer_secret = Omnisocial.service_configs[:twitter].app_secret
        config.oauth_token = current_user.login_account.token
        config.oauth_token_secret = current_user.login_account.secret
      end
    end
  end
end
