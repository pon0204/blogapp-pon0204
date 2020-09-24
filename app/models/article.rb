# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
    validates :title, presence: true
    validates :title, length: {minimum: 2, maximum: 100 } #length文字の長さ 2文字以上ないとダメだよ maxmimumで100文字以下
    validates :title, format: {with: /\A(?!\@)/}   #正規表現先頭に@がついてるとエラー
    
    validates :content, length: {minimum: 10}
    validates :content, presence: true #文字を入力していないとエラー
    validates :content, uniqueness: true  #一意であるかを確認する この場合は記事の内容 普段はメアドやユーザー名
    validate :validate_title_and_content_length

    has_many :comments, dependent: :destroy#複数形
    belongs_to :user #所属する意味 userに紐づいている 単数形
    
    def display_created_at
        I18n.l(self.created_at, format: :default) #jaymlのデフォルト時間の表示
    end

    def author_name
      user.display_name
    end

    private
    def validate_title_and_content_length
       char_count = self.title.length + self.content.length #文字のカウント
       errors.add(:content,'100文字以上で!') unless char_count > 100  
         #100文字以下であれば #コンテントカラムにたいしてエラー  #errors.addは自分でエラーを追加している。
       end
    end
