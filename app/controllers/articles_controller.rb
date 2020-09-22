class ArticlesController < ApplicationController
   before_action :set_article, only: [:show] #全てのアクション前で実施
   before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] #ログインしていないと使用できない様になる

    def index
        @articles = Article.all #記事の中身を配列にして代入
    end
    def show
    end

    def new
        @article = current_user.articles.build  #ログインしているユーザーを取得し、空の箱を作っている

    end
def create
    @article = current_user.articles.build(article_params) #ログインユーザーの空の箱を作っている
    if @article.save
    redirect_to article_path(@article),notice: '保存できたよ'
    else
        flash.now[:error] = '保存に失敗しました'
        render :new
    end
    end

def edit
    @article = current_user.articles.find(params[:id]) #他人に編集されない様に、current_userを付ける
end

def update
    @article = current_user.articles.find(params[:id]) #他人に編集されない様に、current_userを付ける
   if @article.update(article_params)      #update【値更新】のメソッドがある。フォームの値を指定(params)
    redirect_to article_path(@article), notice: '更新できました'     #パスを指定して記事のページに飛ぶ
   else
    flash.now[:error] = '更新できませんでした' #メッセージの表示
    render :edit #編集画面に移動
   end
end

def destroy
    article = current_user.articles.find(params[:id]) #記事のid取得 @を付けると、viewで表示出来る
    article.destroy! #記事の削除 !はデストロイ失敗した時にエラーがでて処理が止まる。
    redirect_to root_path, notice: '削除に成功しました' #削除後、記事一覧に飛ぶ
end

private
def article_params  #フォームの入力内容が回ってくる
    params.require(:article).permit(:title, :content)
end

def set_article   #以下を各実行前に処理
    @article = Article.find(params[:id]) #paramsidで記事のId 記事のidを取得@articleに代入 @はビューに渡すため
end
end
