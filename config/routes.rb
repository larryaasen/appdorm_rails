RailsAppdorm::Application.routes.draw do
  devise_for :users #, :path_names => { :sign_up => "register" }

  resources :builds  

  match '/organizations/add_user', :to => 'organizations#add_user'
  resources :organizations
  
  match '/install', :to => 'builds#install'
  
  match '/upload',  :to => 'builds#new'
  
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  
  root :to => 'pages#home'
end
