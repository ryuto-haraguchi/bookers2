Rails.application.routes.draw do


  get 'home/about' => 'homes#about', as: 'about'

  devise_for :users
  resources :users, only: [:show, :edit, :update, :index]

  resources :books

  root to: 'homes#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
