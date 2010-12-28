class User < Omnisocial::User
  has_many :articles

  scope :twitter,
        :include => :login_accounts,
        :conditions => {:login_accounts => {:type => 'Omnisocial::TwitterAccount'}}
end
