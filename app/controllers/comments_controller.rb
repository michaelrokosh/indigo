class CommentsController < ApplicationController
    before_filter :authenticate_user!
	def create
		@post = Post.find(params[:post_id])
		#@comment = @post.comments.create(comment_params) 
		@comment = current_user.comments.create(comment_params)
		redirect_to @post
	end

	private
		def comment_params
	      params.require(:comment).permit(:commenter, :body, :post_id)
	    end
end
