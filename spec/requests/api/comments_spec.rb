require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:comments) { create_list(:comment, 3, article: article)} #紐づいた状態を作る 複数作成時はcreate_list
  describe 'GET /api/comments' do
    it '200 status' do
      get api_comments_path(article_id: article.id) #記事のIDを指定する
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body.length).to eq 3 #コメントの数を見てる
      expect(body[0]['content']).to eq comments.first.content
      expect(body[1]['content']).to eq comments.second.content
      expect(body[2]['content']).to eq comments.third.content
      

    end
  end
end