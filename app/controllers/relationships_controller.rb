class RelationshipsController < ApplicationController
	before_action :signed_in_user
	
  respond_to :html, :js

	def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		respond_with @user
	end

	# we can destroy the relationship right here
	# defer it to user may be beneficial if more work need to be done
	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		respond_with @user
	end
end