class TagsController < ApplicationController
	def show
		@tag = ActsAsTaggableOn::Tag.find_by name: params[:id]
		@posts = Post.tagged_with(@tag)
	end
end
