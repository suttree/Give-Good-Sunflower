GiveGoodSunflower::Application.routes.draw do
  root :to => "home#index"

  match "/unread", :to => "home#unread", :as => 'unread'
  match "/unread/next", :to => "home#next", :as => 'unread_next'
  match "/unread/prev", :to => "home#prev", :as => 'unread_prev'

  match "/archives(/:page)", :to => "home#archives", :as => 'archives'

  match "/read/:id", :to => "home#read", :as => 'read'

  match "/cron", :to => "home#cron"

  match "/r(/:page)", :to => "home#r", :as => 'stack'
end
