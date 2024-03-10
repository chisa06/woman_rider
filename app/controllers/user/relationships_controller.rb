class User::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end
  
  def destroy
    user = User.find(params[:id]) # リレーションシップを持つユーザーのIDを取得
    current_user.unfollow(user)
    redirect_to request.referer
  end
  
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id).present?
  end
  
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
