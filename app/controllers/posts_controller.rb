class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  #before actions get rooted and run it will find_post for particluar
  #action
  def index
    @posts = Post.all.order("created_at DESC")
  #grabbing all of our posts from our model and ordering them
  #by the created_at field and by Descending order. This is getting
  #assigned to the @posts variable.
  end
#def new defines the post
  def new
    @post = Post.new
  end
#def create allows us to create the post with params
  def create
    @post =Post.new(post_params)
    #if everything went well, send to post (show)
    #else bring back to new post
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    # @post = Post.find(params[:id])DRY
    #we want to find the correct post by the post id
  end

  def edit
    # @post = Post.find(params[:id]) DRY
  end

  def update
    #@post = Post.find(params[:id]) Being removed for DRY reasons
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
#security feature of Ruby we need this private
  private
#post_params defines what the params are so if we
#require a post, we need to permit it to have title and body
#on the post table. If we do not permit, it doesn't get saved
  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
