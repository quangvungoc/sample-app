module SessionsHelper
	def sign_in(user)
	   	remember_token = User.new_remember_token
	   	cookies.permanent[:remember_token] = remember_token
	   	user.update_attribute(:remember_token, User.encrypt(remember_token))
	   	self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	# assignment definition
	def current_user=(user)
    	@current_user = user
  	end

  	# retrieve current_user user.email is not accessing the field email of
  	# an User but calling a getter or a setter

  	# if we use @current_user = user, it could be fall if the user change
  	# page and the session ended prematurely. On the other hand, cookies
  	# doesn't change.
  	def current_user
    	remember_token = User.encrypt(cookies[:remember_token])
    	@current_user ||= User.find_by(remember_token: remember_token)
  	end

  	def sign_out
  		# change remember_token for security reason as the cookies may be
  		# stolen since normally deleting the cookies from the browser should
  		# be enough
    	current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    	cookies.delete(:remember_token)
    	self.current_user = nil
  	end
end
