Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'


  post    'signup',  to: 'users#create'
  post    'signin',  to: 'sessions#create'

  # get     'profile',  to: 'profiles#show'  
  # post    'profile',  to: 'profiles#create'
  
  post     'posts-public',    to: 'posts#public'
  post     'users/profiles',   to: 'profiles#public' 

  resources :users, except: [:new, :edit] do
    resources :posts
    resources :profiles, except: [:index]
  end

  # get     'post',     to: 'posts#show'
  # post    'post',     to: 'posts#create'

end
