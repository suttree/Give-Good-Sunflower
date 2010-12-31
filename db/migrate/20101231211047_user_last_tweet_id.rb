class UserLastTweetId < ActiveRecord::Migration
  def self.up
    add_column :users, :last_tweet_id, :integer, :limit => 8
  end

  def self.down
    remove_column :users, :last_tweet_id
  end
end
