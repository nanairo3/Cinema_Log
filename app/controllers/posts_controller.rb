class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
  end
  
  def new
    @post = Post.new
    @movie = Movie.find(params[:movie_id])
  end

  def create
    @post = current_user.posts.build(content: params[:content], movie_id: params[:movie_id])
    if @post.save
      flash[:notice] = '投稿を作成しました'
      redirect_to movie_path(params[:movie_id])
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params_edit)
      flash[:notice] = "投稿を更新しました"
      redirect_to movie_path(@post.movie_id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to movie_path(@post.movie_id)
  end
  
  private
    def post_params_edit
      params.require(:post).permit(:content)
    end
end
