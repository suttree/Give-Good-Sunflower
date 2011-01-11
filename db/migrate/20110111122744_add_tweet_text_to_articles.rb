class AddTweetTextToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :tweet_text, :text
  end

  def self.down
    remove_column :articles, :tweet_text
  end
end
