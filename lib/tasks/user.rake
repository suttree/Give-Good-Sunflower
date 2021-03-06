desc "Import tweets and store the resulting linked content for a specific user"
task :user => :environment do
  user = User.includes(:login_accounts).where("login_accounts.login = '#{ARGV[1]}'").first
  puts "Running cron for #{user.login} at #{Time.now}"

  setup_twitter_for(user)

  tweets = if user.last_tweet_id
    Twitter.home_timeline(:count => 250, :since => user.last_tweet_id, :include_rts => 0)
  else
    Twitter.home_timeline(:include_rts => 0)
  end

  next if tweets.nil?

  tweets.each do |tweet| 
    urls = URI.extract(tweet.text, %w(http https))
    next if urls.nil?

    urls.each do |url|
      url = unshorten(url)
      puts url

      next if url.include? "http://fb.me"
      next if url.include? "http://yfrog.com"
      next if url.include? "http://twitpic.com"
      next if url.include? "http://instagr.am"
      next if url.include? "http://www.youtube.com"
      next if url.include? "http://www.tweekly.fm"
      next if url.include? "http://foursquare.com"

      begin
        doc = Pismo::Document.new(url)

        title = if url =~ /theatlantic.com/
          doc.html_title
        else
          (doc.title.nil? ? doc.html_title : doc.title)
        end

        article = user.articles.create(
          :tweet_id => tweet.id,
          :twitter_screen_name => tweet.user.screen_name,
          :tweet_text => tweet.text,
          :url => url,
          :favicon => doc.favicon,
          :title => title,
          :author => doc.author,
          :lede => doc.lede,
          :keywords => '',
          :html_body => clean_up(doc.html_body),
          :body => clean_up(doc.body)
        )
      rescue Exception => e
        puts "Catching exception for #{user.login} at #{Time.now}"
        puts e.message
      ensure
        user.update_attributes(:last_tweet_id => tweet.id)
      end
    end
  end
end

private
# Hack, hack, hack
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

def setup_twitter_for(user)
  Twitter.configure do |config|
    config.consumer_key = Omnisocial.service_configs[:twitter].app_key
    config.consumer_secret = Omnisocial.service_configs[:twitter].app_secret
    config.oauth_token = user.login_account.token
    config.oauth_token_secret = user.login_account.secret
  end
end

def clean_up(text)
  entities = ['0x85', '0xf670696e', '0xb4', '0xe97365', '0xe96e6f']
  entities.each do |entity|
    text.gsub!(/entity/, ' ')
  end
  text.scan(/[[:print:]]/).join
end
