# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
    has_one_attached :eyecatch   #画像を一枚アップロード
    has_rich_text :content

    validates :title, presence: true
    validates :title, length: {minimum: 2, maximum: 100 } #length文字の長さ 2文字以上ないとダメだよ maxmimumで100文字以下
    validates :title, format: {with: /\A(?!\@)/}   #正規表現先頭に@がついてるとエラー
    

    validates :content, presence: true #文字を入力していないとエラー


    has_many :comments, dependent: :destroy#複数形
    has_many :likes, dependent: :destroy
    belongs_to :user #所属する意味 userに紐づいている 単数形
    
    end
