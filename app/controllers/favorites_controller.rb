class FavoritesController < ApplicationController
  before_action :authenticate_user! #ログインしているユーザーのみの機能

  def index
    @articles = current_user.favorite_articles
  end

end