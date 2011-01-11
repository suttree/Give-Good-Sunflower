class Article < ActiveRecord::Base
  belongs_to :user

  serialize :keywords

  validates_uniqueness_of :tweet_id
  validates_presence_of :body, :html_body, :title, :url

  scope :list, :order => 'created_at DESC'
  scope :unread, :conditions => {:read_at => nil}, :order => 'created_at DESC'
  scope :read, :conditions => ['read_at IS NOT NULL'], :order => 'updated_at DESC'

  def mark_as_read
    update_attribute(:read_at, Time.now)
  end

  def archived?
    !read_at.nil?
  end

  def read?
    archived?
  end

  def unread?
    !read?
  end
end
