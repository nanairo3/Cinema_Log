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
  end

  def update
  end

  def destroy
  end
end
