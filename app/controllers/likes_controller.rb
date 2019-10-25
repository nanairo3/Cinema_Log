class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.build(post_id: params[:post_id])
    like.save
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy
  end
  
end
