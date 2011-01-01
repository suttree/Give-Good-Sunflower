GiveGoodSunflower::Application.routes.draw do
  root :to => "home#index"

  match "/unread(/:page)", :to => "home#unread"
  match "/archives(/:page)", :to => "home#archives"
  match "/read/:id", :to => "home#read"
  match "/cron", :to => "home#cron"
end
