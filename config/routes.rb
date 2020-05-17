Rails.application.routes.draw do
  root 'books#top'
  devise_for :users
  get 'home/about' => "books#about"
  
  resources :users

  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end

 end
