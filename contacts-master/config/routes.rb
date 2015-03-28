Route66::Application.routes.draw do
  resources :users, only: [:index, :show, :update, :destroy, :create] do
    resources :contacts, only: [:index]
    resources :comments, only: [:index]
  end

  resources :contacts, only: [:show, :update, :destroy, :create] do
    resources :comments, only: [:index]
  end

  resources :contact_shares, only: [:destroy, :create]

  # get 'users'             => 'users#index',   :as => 'users'
  # post 'users'            => 'users#create'
  # get 'users/new'         => 'users#new',     :as => 'new_user'
  # get 'users/:id/edit'    => 'users#edit',    :as => 'edit_user'
  # get 'users/:id'         => 'users#show',    :as => 'user'
  # patch 'users/update'    => 'users#update'
  # put 'users/update'      => 'users#update'
  # delete 'users/:id'      => 'users#destroy'


end
