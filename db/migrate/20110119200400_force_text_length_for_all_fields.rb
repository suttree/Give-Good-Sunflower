class ForceTextLengthForAllFields < ActiveRecord::Migration
  def self.up
   change_column(:articles, :title, :text)
   change_column(:articles, :lede, :text)
   change_column(:articles, :body, :text)
   change_column(:articles, :html_body, :text)
  end

  def self.down
   change_column(:articles, :title, :string)
   change_column(:articles, :lede, :string)
   change_column(:articles, :body, :string)
   change_column(:articles, :html_body, :string)
  end
end
