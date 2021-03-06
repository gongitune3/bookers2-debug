Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end

  resources :books,only: [:show,:index,:edit,:update,:destroy,:create] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create]
  end
  resources :book_comments, only: [:destroy]

  root 'home#top'
  get 'home/about'
  get '/search', to: 'search#search'
  # post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  # post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
end