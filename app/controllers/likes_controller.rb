class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.build(post: @post)
    like.save!
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.build(post: @post)
    like.destroy!
  end

end
