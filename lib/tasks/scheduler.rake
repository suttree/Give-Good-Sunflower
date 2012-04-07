desc "Delete old articles"
task :tidy => :environment do
  Article.destroy_all( ['updated_at <?', 1.month.ago] )
end

desc "Import tweets and store the resulting linked content"
task :cron => :environment do
  # Pick 4 random users and me, then parse their twitter feeds for links
  (User.twitter.order('random()').limit(4) << User.find(37)).each do |user|
    puts "Running cron for #{user.login} at #{Time.now}"

    setup_twitter_for(user)

    begin
      tweets = if user.last_tweet_id
        Twitter.home_timeline(:count => 100, :since => user.last_tweet_id, :include_rts => 0)
      else
        Twitter.home_timeline(:include_rts => 0)
      end
    rescue
      puts "Failed to process tweets for #{user.login}"
      next
    end

    next if tweets.nil?

    tweets.each do |tweet| 
      urls = URI.extract(tweet.text, %w(http https))
      next if urls.nil?

      urls.each do |url|
        url = unshorten(url)
        puts url

        next if url.include? 'fb.me'
        next if url.include? '4sq.com'
        next if url.include? 'yfrog.com'
        next if url.include? 'twitpic.com'
        next if url.include? 'instagr.am'
        next if url.include? 'youtube.com'
        next if url.include? 'tweekly.fm'
        next if url.include? 'foursquare.com'
        next if url.include? 'thisismyjam.com'

        begin
          doc = Pismo::Document.new(url)
          next if doc.body.length < 500 # we only want decent length articles to read

          article = user.articles.create(
            :tweet_id => tweet.id,
            :twitter_screen_name => tweet.user.screen_name,
            :tweet_text => tweet.text,
            :url => url,
            :favicon => doc.favicon,
            :title => clean_up(doc.html_title),
            :author => doc.author,
            :lede => clean_up(doc.lede),
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
  puts "Done"
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
  text.gsub!(/\n/, ' ')
  text.scan(/[[:print:]]/).join
end
