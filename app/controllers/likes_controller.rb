class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    article = Article.find(params[:article_id])
    article.likes.create!(user_id: current_user.id)  #has_manyするとクリエイト出来る
    redirect_to article_path(article)
  end

  def destroy
    article = Article.find(params[:article_id])
    like = article.likes.find_by!(user_id: current_user.id)   #自分がいいねしているやつを探す
    like.destroy!
    redirect_to article_path(article)
  end

end