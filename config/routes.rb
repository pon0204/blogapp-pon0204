require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  
root to: 'articles#index' #記事一覧の表示



resources :articles 

  resources :accounts, only:[:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
  end


scope module: :apps do
  resource :timeline, only:[:show]
  resource :profile, only: [:show, :edit, :update]
  resources :favorites, only: [:index]
end

  namespace :api, defaults: {format: :json} do
    scope '/articles/:article_id' do
      resources :comments, only: [:index, :new, :create]
      resource :like, only: [:show ,:create, :destroy] #idを使用しなくても削除出来るから単数形にしてる
    end
  end
end



# get 記事の表示
# put 記事の更新
# post 記事の作成
# only以降はいらない onlyはこのアクションしか使えませんの意味
#resources :articles, only: [:show, :new, :create, :edit, :update, :destroy]  アークティルパスのアクションの指定 updateでputとpatchのパス追加 destroyでdeleteパス追加
