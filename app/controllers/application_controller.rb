class ApplicationController < ActionController::Base
	before_filter :find_states
	#before_filter :authorize_admin!, :except => [:index, :show]
  protect_from_forgery
	private
	def authorize_admin!
		authenticate_user!
		unless current_user.admin?
				flash[:alert]= "You must be an admin to do that."
				redirect_to root_path
		end
	end
	def find_states
		@states = State.all
	end	
end
