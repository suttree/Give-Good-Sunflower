class Article < ActiveRecord::Base
  belongs_to :user

  serialize :keywords

  validates_uniqueness_of :tweet_id
  validates_presence_of :body, :html_body, :title, :url

  default_scope :order => 'created_at DESC'
  scope :unread, :conditions => {:read_at => nil}
  scope :read, :conditions => ['read_at IS NOT NULL']

  def mark_as_read
    update_attributes(:read_at => Time.now)
  end

  def archived?
    !read_at.nil?
  end
end
