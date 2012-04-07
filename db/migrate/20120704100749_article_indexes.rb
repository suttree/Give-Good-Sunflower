class ArticleIndexes < ActiveRecord::Migration
  def self.up
    add_index :articles, [:user_id, :created_at]
  end

  def self.down
    remove_index :articles, [:user_id, :created_at]
  end
end
