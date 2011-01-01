class ArticleReadAtTimestamp < ActiveRecord::Migration
  def self.up
    add_column :articles, :read_at, :timestamp, :default => nil
    execute("UPDATE articles SET read_at = NULL")
  end

  def self.down
    remove_column :articles, :read_at
  end
end
