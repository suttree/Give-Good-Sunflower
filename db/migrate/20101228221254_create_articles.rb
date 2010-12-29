class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.integer :user_id, :null => false
      t.integer :tweet_id, :limit => 8, :null => false # bigint
      t.string :twitter_screen_name
      t.text :url, :null => false
      t.text :favicon
      t.text :title
      t.text :author
      t.text :lede
      t.text :html_body
      t.text :body
      t.text :keywords
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
