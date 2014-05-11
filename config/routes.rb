BackChannelApplication::Application.routes.draw do
  resources :votes
  resources :posts
  resources :comments
  resources :categories
  resources :users
  match '/user/login', :controller => 'users', :action => 'login'
  match '/user/logout', :controller => 'users', :action => 'logout'
  match '/user/myhome', :controller => 'users', :action => 'myhome'
  match '/user/reports', :controller => 'users', :action => 'reports'
  match '/post/search', :controller => 'posts', :action => 'search'
  root :to => 'users#myhome'
end
