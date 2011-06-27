class IndexOnArticlesReadAt < ActiveRecord::Migration
  def self.up
    add_index :articles, :read_at
  end

  def self.down
    remove_index :articles, :read_at
  end
end
