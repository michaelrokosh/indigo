class CommentsController < ApplicationController
    before_filter :authenticate_user!
	def create
		@post = Post.find(params[:post_id])
		#@comment = @post.comments.create(comment_params) 
		@comment = current_user.comments.create(comment_params)
		redirect_to @post
	end

    def vote_up
    	@post = Post.find(params[:post_id])
      begin
        current_user.vote_for(@comment = Comment.find(params[:id]))
        #render :nothing => true, :status => 200
        redirect_to :back
      rescue ActiveRecord::RecordInvalid
        #render :nothing => true, :status => 404
        redirect_to :back
      end
    end

    def vote_down
    	@post = Post.find(params[:post_id])
      begin
        current_user.vote_against(@comment = Comment.find(params[:id]))
        #render :nothing => true, :status => 200
        redirect_to :back
      rescue ActiveRecord::RecordInvalid
        #render :nothing => true, :status => 404
        redirect_to :back
      end
    end

	private
		def comment_params
	      params.require(:comment).permit(:commenter, :body, :post_id)
	    end
end
