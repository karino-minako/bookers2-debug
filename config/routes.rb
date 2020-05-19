Rails.application.routes.draw do
  get '/search' => 'search#search'
  root 'books#top'
  devise_for :users
  get 'home/about' => "books#about"
  
  resources :users do
  	get :search, on: :collection
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
