Rails.application.routes.draw do
  root 'books#top'
  devise_for :users
  get 'home/about' => "books#about"
  
  resources :users
  resources :books
 end
