class User < Omnisocial::User
  scope :twitter,
        :include => :login_accounts,
        :conditions => {:login_accounts => {:type => 'Omnisocial::TwitterAccount'}}
end
