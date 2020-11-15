# frozen_string_literal: true

module UserDecorator
    def display_name
        profile&.nickname || self.email.split('@').first  #ぼっち演算子 nillじゃ無いときに左実行 nillなときは右実行
    end

    def avatar_image
        if profile&.avatar&.attached?
            profile.avatar
        else
        'default-avatar.png'
        end
    end
end
