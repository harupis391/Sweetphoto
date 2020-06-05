class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
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
      flash.now[:danger] = 'アカウントの登録に失敗しました。'
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
      flash[:success] = 'アカウントを編集しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'アカウントの編集に失敗しました。'
      render :edit
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
