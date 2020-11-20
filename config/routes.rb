Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root to: 'articles#index' #記事一覧の表示

resource :timeline, only:[:show]

resources :articles do
  resources :comments, only: [:index, :new, :create]

  resource :like, only: [:show ,:create, :destroy] #idを使用しなくても削除出来るから単数形にしてる
  end

  resources :accounts, only:[:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
  end

  resource :profile, only: [:show, :edit, :update]

  resources :favorites, only: [:index]

end



# get 記事の表示
# put 記事の更新
# post 記事の作成
# only以降はいらない onlyはこのアクションしか使えませんの意味
#resources :articles, only: [:show, :new, :create, :edit, :update, :destroy]  アークティルパスのアクションの指定 updateでputとpatchのパス追加 destroyでdeleteパス追加
