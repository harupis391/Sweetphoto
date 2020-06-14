class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      @comment.notify_comment(current_user)
      flash[:success] = 'コメントしました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = '入力内容に誤りがあります。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
      redirect_back(fallback_location: root_path)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_back(fallback_location: root_path)
    end
  end
  
end
