	class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])

	end

	def index
		@users = User.all	

	end

	def new
		@user = User.new
	end

	def edit
    	@user = User.find(params[:id])
  	end

  	def create
  		@user = User.new(params[:user])
  		
  	end

  	def destroy
	    @user = User.find(params[:id])
	    @user.destroy

  	end
end
