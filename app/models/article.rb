class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def display_created_at
        I18n.l(self.created_at, format: :default) #jaymlのデフォルト時間の表示
    end
end

