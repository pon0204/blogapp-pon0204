class Apps::TimelinesController < Apps::ApplicationController
  
  def show
    user_ids = current_user.followings.pluck(:id) #pluckでfollowingのidを取ってこれる
    @articles = Article.where(user_id: user_ids)
  end
end
