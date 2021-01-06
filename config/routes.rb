Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks'
  }

  devise_scope :user do
    root :to => "users/sessions#new"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  resources :users do
    collection do
      get "mypage", :to => "users#mypage"
      get "mypage/edit", :to => "users#edit"
      put "mypage", :to => "users#update"
      get "mypage/edit_password", :to => "users#edit_password"
      put "mypage/password", :to => "users#update_password"
      get "mypage/favorite", :to => "users#favorite"
    end
  end

  resources :theaters do
    member do
      post :favorite
    end
    resources :reviews, only: [:create]
  end
  resources :stages
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
