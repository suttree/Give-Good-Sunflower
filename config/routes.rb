GiveGoodSunflower::Application.routes.draw do
  root :to => "home#index"
  match "/unread(/:page)", :to => "home#unread"
  match "/cron", :to => "home#cron"
end
