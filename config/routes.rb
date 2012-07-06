Golfstats::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'sign_in',  to: 'users/sessions#new',     as: :new_user_session
    get 'sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
  resources :users, only: [:show, :edit, :update] do
    resource :import, only: :create
  end

  resources :courses, only: [:index, :show, :new, :create], shallow: true do
    resources :rounds, except: :destroy
    resource :course_note, except: [:index, :show, :create], path: 'note', as: :course_note
    resource :course_note, only: :create, path: 'note', as: :course_notes
  end

  get 'course_handicap', to: 'course_handicap#show'
  root to: "pages#home"

end
