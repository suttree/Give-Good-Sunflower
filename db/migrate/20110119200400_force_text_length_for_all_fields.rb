class ForceTextLengthForAllFields < ActiveRecord::Migration
  def self.up
   change_table(:articles) do |t|
     t.column :title, :text
     t.column :lede, :text
     t.column :body, :text
     t.column html_body :text
    end
  end

  def self.down
    # No need for a downward migration
  end
end
