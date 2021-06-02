Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 # ========= ユーザー(user)のルーティング ================
  root to: 'homes#top'
  get 'about' => 'homes#about'

scope module: :user do
  resources 'shops', only: [:index, :show, :edit, :update, :new, :create, :destroy] do
    resources 'reviews', only: [:index, :create, :destroy]
    resources 'bookmarks', only: [:create, :destroy]
  end
  get 'search' => 'shops#search'

  resources 'users', only: [:show, :edit, :update] do
    member do
      get :followings, :followers
    end
  end
  get 'user/quit_confirm' => 'users#quit_confirm'
  patch 'user/quit' => 'users#quit'

  resources 'relationships', only: [:create, :destroy]

  resources 'tweets', only: [:index, :new, :create, :destroy]

  resources 'contacts', only: [:new, :create]
  get 'thanks' => 'contacts#thanks'
end

# ========= 管理者側(admin)のルーティング ================

  namespace :admin do
    resources 'users', only: [:index, :show, :edit, :update]
    resources 'contacts', only: [:index, :update]
  end


end