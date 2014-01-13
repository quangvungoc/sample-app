class RelationshipsController < ApplicationController
	before_action :signed_in_user

	def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	# we can destroy the relationship right here
	# defer it to user may be beneficial if more work need to be done
	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end
end