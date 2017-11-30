class PostsController < ApplicationController

  before_action :require_sign_in, except: [:show, :index]
  before_action :authorize_user, except: [:show, :index]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :show]


  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def authorize_user
    unless current_user.admin? || current_user.chiefAdmin?
      flash[:alert] = "You must be an admin to do that"
      redirect_to posts_path
    end
  end

  def authorize_chief_user
    unless current_user.chiefAdmin?
      flash[:alert] = "You must be an admin to do that"
      redirect_to posts_path
    end
  end
end
