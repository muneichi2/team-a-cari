class CommentsController < ApplicationController
  def create
    Comment.create(text: comment_params[:text], item_id: comment_params[:item_id], user_id: current_user.id)
      redirect_to item_path(params[:item_id]), notice: 'コメントが送信されました'
  end

  private
  def comment_params
    params.permit(:text, :item_id)
  end

end
