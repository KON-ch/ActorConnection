Rails.application.routes.draw do
  
  devise_for :admins, :controllers => {
    :sessions => 'admins/sessions'
  }

  devise_scope :admin do
    get "dashboard", :to => "dashboard#index"
    get "dashboard/login", :to => "admins/sessions#new"
    post "dashboard/login", :to => "admins/sessions#create"
    get "dashboard/logout", :to => "admins/sessions#destroy"
  end

  namespace :dashboard do
    resources :admins, only: [:index, :destroy]
    resources :users, only: [:index, :destroy]
    resources :theaters, except: [:show]
    resources :stages, except: [:show]
    resources :places, except: [:show]
    resources :movies, except: [:show]
    resources :countries, only: [:index, :create]
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks'
  }

  devise_scope :user do
    root "posts#index"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  resources :users, only: [:show, :edit, :update] do
    collection do
      get "mypage", :to => "users#mypage"
      put "mypage", :to => "users#update"
      get "mypage/edit_password", :to => "users#edit_password"
      put "mypage/password", :to => "users#update_password"
      get "mypage/favorite", :to => "users#favorite"
      get "mypage/review", :to => "users#review"
      delete "mypage/delete", :to => "users#destroy"
    end
  end

  concern :reviewable do
    resources :reviews, only: [:create]
  end

  concern :favorable do
    post 'favorite', on: :member
  end

  resources :reviews, only: [:update, :destroy] do
    concerns :favorable
  end

  resources :theaters, concerns: [:favorable, :reviewable]

  resources :stages, concerns: [:favorable, :reviewable]

  resources :movies, concerns: [:favorable, :reviewable]

  resources :posts, only: [:index] do
    concerns :favorable
  end

  resources :webs, only: [:index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
