class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
  end
  
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
  
    def post_params
      params.permit(:content)
    end
    
    def post_params_edit
      params.require(:post).permit(:content)
    end
    
    def ensure_correct_user
      @post = Post.find(params[:id])
        if current_user.id != @post.user_id
          flash[:notice] = "権限がありません"
          redirect_to root_path
        end
    end
end
