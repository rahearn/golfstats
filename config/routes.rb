Golfstats::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' } do
    get 'sign_in',  :to => 'users/sessions#new',     :as => :new_user_session
    get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  end
  resource :user, :only => :show

  resources :courses, :only => [:index, :show, :new, :create], :shallow => true do
    resources :rounds, :except => :destroy
  end

  root :to => "pages#home"

end
