class Article < ActiveRecord::Base
  belongs_to :user

  serialize :keywords

  validates_uniqueness_of :tweet_id

  default_scope :order => 'created_at DESC'
end
