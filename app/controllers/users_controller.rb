class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user, :not_delete_admin,      only: :destroy
  
  before_action :not_signed_in_user,  only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

	def show 
		@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
	end

	def new
		@user = User.new
	end

  def edit
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

	def create
	    @user = User.new(user_params)    # Not the final implementation!
	    if @user.save
          sign_in @user
          flash[:success] = "Welcome to the Sample App!"
	      	redirect_to @user
	    else
	      	render 'new'
	    end
	end

	private

  	def user_params
    	params.require(:user).permit(:name, :email, :password,
      	    	                       :password_confirmation)
  	end

    def not_signed_in_user
      redirect_to(root_url, notice: "Already signed in") unless !signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def not_delete_admin
      @user = User.find(params[:id])
      redirect_to(root_url) unless !@user.admin?
    end
end
