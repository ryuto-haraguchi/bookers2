Rails.application.routes.draw do

  get 'books/new'
  get 'books/index'
  get 'books/show'
  get 'books/edit'
  root to: 'homes#home'

  get 'home/about' => 'homes#about', as: 'about'

  devise_for :users
  resources :users, only: [:show, :edit, :update]

  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
