class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end
    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end
    
def create
    @article = Article.new(article_params)
    if @article.save
    redirect_to article_path(@article),notice: '保存できたよ'
    else 
        flash.now[:error] = '保存に失敗しました'
        render :new
    end
    end

def edit
@article = Article.find(params[:id]) #paramsidで記事のId 記事のidを取得@articleに代入 @はビューに渡すため
end

def update
    @article = Article.find(params[:id])   #記事のidを取得する
   if @article.update(article_params)      #update【値更新】のメソッドがある。フォームの値を指定(params)
    redirect_to article_path(@article), notice: '更新できました'     #記事のページに飛ぶ
   else
    flash.now[:error] = '更新できませんでした' #メッセージの表示
    render :edit #編集画面に移動
   end
end

def destroy
    article = Article.find(params[:id]) #記事のid取得
    article.destroy! #記事の削除 !はデストロイ失敗した時にエラーがでて処理が止まる。
    redirect_to root_path, notice: '削除に成功しました' #削除後、記事一覧に飛ぶ
end

private
def article_params  #フォームの入力内容が回ってくる
    params.require(:article).permit(:title, :content)
end
end