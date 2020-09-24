class CommentsController < ApplicationController
    def new
      article = Article.find(params[:article_id])
      @comment = article.comments.build
    end

    def create
        article = Article.find(params[:article_id])
        @comment = article.comments.build(comment_params) #記事を取得して、びるどしてcommentに代入する
        if @comment.save
            redirect_to article_path(article), notice: 'コメント取得'
        else
            flash.now[:error] = '更新できませんでした'
            render :new
    end
end

 private
    def comment_params
        params.require(:comment).permit(:content)
    end
  end
