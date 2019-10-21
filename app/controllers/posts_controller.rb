class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
  end
  
  def new
    @post = Post.new
    @movie = Movie.find(params[:id])
  end

  def create
    @post = Post.new(movie_id: params[:id], user_id: current_user.id, content: params[:content])
    if @post.save!
      flash[:notice] = '投稿を作成しました'
      redirect_to movie_path(params[:id])
    else
      render('posts/new')
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
