Golfstats::Application.routes.draw do

  devise_for :users

  root :to => "users#show"

end
