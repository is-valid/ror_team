class PostsController < ApplicationController
  before_action :category, only: [:index , :show]
  def category
    @category = Category.all
  end
  # GET /posts
  def index
    @post = Post.search_posts_based_on_like(params[:search])
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order("id").page(params[:page]).per(5)
  end

end
