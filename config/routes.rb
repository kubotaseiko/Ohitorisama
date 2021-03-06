Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 # ========= ユーザー(user)のルーティング ================

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root to: 'homes#top'
  get 'about' => 'homes#about'
  resource 'contacts', only: [:new, :create] do
    get 'thanks' => 'contacts#thanks'
  end

  scope module: :user do
    resources 'shops', only: [:index, :show, :edit, :update, :new, :create, :destroy] do
      resources 'reviews', only: [:create, :destroy, :index]
      resource 'bookmarks', only: [:create, :destroy]
    end

    get 'search' => 'shops#search'
    get 'rank'=> 'shops#rank'
    get 'hot'=> 'shops#hot'

    resources :tags do
    get 'shops', to: 'shops#tag_search'
    end

    resources 'users', only: [:show, :edit, :update] do
      member do
        get :followings, :followers
      end
    end


    get 'user/quit_confirm' => 'users#quit_confirm'
    patch 'user/quit' => 'users#quit'

    resources 'relationships', only: [:create, :destroy]

    resources 'tweets', only: [:create, :destroy, :new, :show] do
      resource :likes, only: [:create, :destroy]
      resources :tweet_comments, only: [:create, :destroy]
    end



    resources :notifications, only: :index

  end


# ========= 管理者側(admin)のルーティング ================
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :admin do
    resources 'users', only: [:index, :show, :edit, :update]
    resources 'contacts', only: [:index, :update]
    get 'contacts_sort' => 'contacts#contacts_sort'
  end

end