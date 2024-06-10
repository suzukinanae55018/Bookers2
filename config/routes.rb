Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users

  get "home/about" => "homes#about", as: :about
  get "search" => "searches#search"

  resources :notifications, only: [:update]

  resources :groups, only: [:new, :index, :show, :create, :edit, :update]

  resources :books, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end
  resources :users, only: [:new, :create, :index, :show, :edit, :update] do
    get "search" => "users#search"
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
