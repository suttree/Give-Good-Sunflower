class HomeController < ApplicationController
  before_filter :require_user, :only => :unread

  def cron
    User.twitter.each do |user|
      setup_twitter_for(user)

      Twitter.home_timeline.each do |tweet|
        urls = URI.extract(tweet.text, %w(http https))

        urls.each do |url|
          url = unshorten(url)
          begin
            doc = Pismo::Document.new(url)
            article = user.articles.create(
              :tweet_id => tweet.id,
              :twitter_screen_name => tweet.user.screen_name,
              :url => url,
              :favicon => doc.favicon,
              :title => doc.title,
              :author => doc.author,
              :lede => doc.lede,
              :keywords => doc.keywords,
              :html_body => doc.html_body,
              :body => doc.body
            )
          rescue Exception => e
            puts e.message
          end
        end
      end
    end
  end

  protected
  def setup_twitter_for(user)
    Twitter.configure do |config|
      config.consumer_key = Omnisocial.service_configs[:twitter].app_key
      config.consumer_secret = Omnisocial.service_configs[:twitter].app_secret
      config.oauth_token = user.login_account.token
      config.oauth_token_secret = user.login_account.secret
    end
  end
end
