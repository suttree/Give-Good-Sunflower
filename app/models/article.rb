class Article < ActiveRecord::Base
  belongs_to :user

  serialize :keywords

  validates_uniqueness_of :tweet_id
end
