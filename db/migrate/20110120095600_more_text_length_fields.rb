class MoreTextLengthFields < ActiveRecord::Migration
  def self.up
   change_column(:articles, :url, :text)
   change_column(:articles, :favicon, :text)
  end

  def self.down
   change_column(:articles, :url, :string)
   change_column(:articles, :favicon, :string)
  end
end
