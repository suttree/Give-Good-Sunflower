Omnisocial.setup do |config|
  if Rails.env.production?
    config.twitter 'jpwMeLpSjpn0memNj9Gcw', 'xbStUFsHEaG0UJ1sUNzTXeoy20BNwYWBIDwZ0tAqs'
  elsif Rails.env.development?
    config.twitter '80zrC43nJDJGKwEtgbzKyw', 'th5tgN2st8k1cgs0lQOTGCQof2a2XLvhi94Uro9nY'
  end
end
