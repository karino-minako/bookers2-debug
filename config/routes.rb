Rails.application.routes.draw do
  root 'books#top'
  devise_for :users
  get 'home/about' => "books#about"
  
  resources :users do
  	member do
  	  get :following, :followers
  	end
  end

  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]

 end
