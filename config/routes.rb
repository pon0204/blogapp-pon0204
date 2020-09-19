Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root to: 'articles#index' #記事一覧の表示

resources :articles, only: [:show, :new, :create, :edit, :update]  #アークティルパスのアクションの指定 updateでputとpatchのパス追加
end

# get 記事の表示
# put 記事の更新
# post 記事の作成