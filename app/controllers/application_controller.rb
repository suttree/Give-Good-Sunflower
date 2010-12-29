class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :setup_twitter

  def unshorten(url)
    begin
      authorize = UrlShortener::Authorize.new 'suttree', 'R_a13a91dca25fcaa600db741075a291a9'
      client = UrlShortener::Client.new(authorize)
      expand = client.expand(:shortUrl => url)
      expand.url
    rescue
      url
    end
  end
  helper_method :unshorten

  protected
  def setup_twitter
    if current_user && !current_user.nil?
      if current_user.login_account
        Twitter.configure do |config|
          config.consumer_key = Omnisocial.service_configs[:twitter].app_key
          config.consumer_secret = Omnisocial.service_configs[:twitter].app_secret
          config.oauth_token = current_user.login_account.token
          config.oauth_token_secret = current_user.login_account.secret
        end
      end
    end
  end
end
