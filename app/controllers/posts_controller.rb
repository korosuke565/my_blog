class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_writer!


  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    @post.save

    redirect_to "/posts/#{@post.id}"
  end

  def show
  end

  def edit
  end

  def update
    @post.update_attributes(post_params)

    redirect_to "/posts/#{@post.id}"
  end

  def destroy
    @post.destroy

    redirect_to '/'
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :category_id,
      :body
    )

  end

  def set_post
    @post = Post.find(params[:id])
  end

end
