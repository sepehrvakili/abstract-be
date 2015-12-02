Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'


  post    'register',  to: 'users#create'
  post    'login',     to: 'users#login'
  post    'profiles',        to: 'profiles#create'

  get      'posts-public',    to: 'posts#public'
  
  resources :users, except: [:new, :edit] do
    resources :posts
  end

  # get     'post',     to: 'posts#show'
  # post    'post',     to: 'posts#create'

end
