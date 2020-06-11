class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @post = current_user.posts.build  # form_with 用
    @posts = Post.order(id: :desc)
    counts_of(@post)
  end

  def show
    @post = Post.find(params[:id])
    counts_of(@post)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.posts.order(id: :desc)
      flash.now[:danger] = '投稿に失敗しました。'
      render :index
    end
  end

  def edit
  end

  def update
     if @post.update(post_params)
      flash[:success] = '投稿内容を更新しました。'
      redirect_to @post
    else 
      flash.now[:danger] = '入力内容に誤りがあります。'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_to user_path(current_user)
  end

  private
  
  def post_params
    params.require(:post).permit(:content, :image)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  
end