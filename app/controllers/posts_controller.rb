class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def new
    @movie = Movie.find(params[:movie_id])
    @post = @movie.posts.build
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @post = current_user.posts.build(post_params)
    @post.movie = @movie
    if @post.save
      redirect_to movie_path(params[:movie_id]), notice: '投稿を作成しました'
    else
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to movie_path(@post.movie_id), notice: "投稿を更新しました"
    else
      render :edit
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to movie_path(post.movie_id), notice: "投稿を削除しました"
  end
  
  private
  
    def post_params
      params.require(:post).permit(:content)
    end
end
