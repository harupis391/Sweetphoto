class NotificationsController < ApplicationController
  before_action :correct_user
  
  def destroy
    @notification.destroy
    flash[:success] = '通知を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def correct_user
    @notification = current_user.reverses_of_notification.find_by(id: params[:id])
    unless @notification
      redirect_back(fallback_location: root_path)
    end
  end
end
