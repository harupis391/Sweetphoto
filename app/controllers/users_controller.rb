class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [
    :show, :edit, :update, :followings, :followers, :notifications
  ]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = '新規アカウントを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = '入力内容に誤りがあります。'
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
    end
    if @user.update(user_params)
      flash[:success] = 'ユーザ情報を更新しました。'
      redirect_to @user
    else
      flash.now[:danger] = '入力内容に誤りがあります。'
      render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @favorites = @user.likes
    counts(@user)
  end
  
  def feeds
    @post = current_user.posts.build
    @posts = current_user.feed_posts.order(id: :desc)
  end
  
  def notifications
    @notifications = current_user.reverses_of_notification.order(id: :desc)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
  
  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.none
    end
  end
  
  private
  
  def correct_user
      @user = User.find_by(id: params[:id])
    unless @user == current_user
      redirect_to root_url
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :remove_image)
  end
end
