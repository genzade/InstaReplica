class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = 'Post deleted successfully'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption).merge(user: current_user)
  end
end
