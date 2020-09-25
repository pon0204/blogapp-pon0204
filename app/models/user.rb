# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy #複数形記事と紐付け userが削除された場合、記事も削除する
  has_one :profile, dependent: :destroy  #一つの意味 プロフィールを所有している
  

  delegate :birthday, :age, :gender, to: :profile, allow_nil: true  #メソッドを定義しなくても、使える様になる プロフィールモデルからひっぱてくる allow_nilでぼっち演算子
  
  def has_written?(article)
    articles.exists?(id: article.id)
  end

  def display_name
    profile&.nickname || self.email.split('@').first  #ぼっち演算子 nillじゃ無いときに左実行 nillなときは右実行
  end

  # def birthday
  #     profile&.birthday
  # end

  # def gender
  #   profile&.gender
  # end

    def prepare_profile
      profile || build_profile #もしカレントユーザーのプロフィールがあったら取得 ||はオアーの分岐
    end
    
    def avatar_image
      if profile&.avatar&.attached? #アタッチであ風ロードされているかを確認
        profile.avatar
      else
        'default-avatar.png'
      end
    end
end
