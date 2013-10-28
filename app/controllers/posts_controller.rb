class PostsController < ApplicationController

	def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def show
    @post = Post.find(params[:id])
  end 

  def index
    @posts = Post.paginate(:order => "created_at DESC", :page => params[:page], :per_page => 2)
  end


  private
    def post_params
      params.require(:post).permit(:title, :content, :tag_list)
    end
end
