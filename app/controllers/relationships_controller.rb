class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    current_user.notify_follow(user)
    flash[:success] = 'フォローしました。'
    redirect_back(fallback_location: user_path(user))
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = 'フォローを解除しました。'
    redirect_back(fallback_location: user_path(user))
  end
end
