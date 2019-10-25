class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    like = current_user.likes.create(post_id: params[:id])
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    like = current_user.likes.find_by(post_id: params[:id])
    like.destroy
    redirect_back(fallback_location: root_path)
  end
  
end
