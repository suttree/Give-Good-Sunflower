GiveGoodSunflower::Application.routes.draw do
  root :to => "home#index"

  match "/unread(/:page)", :to => "home#unread", :as => 'unread'
  match "/archives(/:page)", :to => "home#archives", :as => 'archives'
  match "/read/:id", :to => "home#read", :as => 'read'
  match "/cron", :to => "home#cron"
end
