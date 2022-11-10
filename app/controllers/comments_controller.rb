class CommentsController < ApplicationController
  def create 
    unless user_signed_in?
      redirect_to action: :index
    end
       @comment = Comment.new(comment_params)
    if @comment.save
       redirect_to "/prototypes/#{@comment.prototype.id}"
    end
  end

  def show
    @comments =Comment.find(params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(prototype_id: params[:prototype_id], user_id: current_user.id)
  end
end
