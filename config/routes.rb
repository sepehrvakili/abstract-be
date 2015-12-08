Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  post    'register',  to: 'users#create'
  post    'login',     to: 'users#login'
  post    'profiles',  to: 'profiles#create'

  get      'posts',                   to: 'posts#public'
  delete   'posts/:post_id/likes',    to: 'likes#destroy'
  get      'users/:user_id/likes',    to: 'likes#index'

  resources :posts do
    resources :comments
    resources :likes
    resources :moodpieces
  end

  resources :users, except: [:new, :edit] do
    resources :posts, except: [:create, :show, :update, :destroy]
  end

end