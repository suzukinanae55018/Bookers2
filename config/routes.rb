Rails.application.routes.draw do

  root to: 'homes#top'
  devise_for :users

  get 'home/about' => 'homes#about', as: :about

  resources :books, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
    resource :favorite, only: [:create, :destroy]
  end
  resources :users, only: [:new, :create, :index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
