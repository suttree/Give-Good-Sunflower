class Article < ActiveRecord::Base
  belongs_to :user

  serialize :keywords

  validates_uniqueness_of :tweet_id
  validates_presence_of :body, :html_body, :title, :url

  default_scope :order => 'created_at DESC'
end
