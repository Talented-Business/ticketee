class Admin::UsersController< Admin::BaseController
	before_filter :find_user,:only=> [:show, :edit, :update, :destroy]
	def index
		@users= User.all(:order=>"email")
	end
	def new
		@user=User.new
	end
	def create
		admin = params[:user][:admin] == "1"
		params[:user].delete(:admin)
		@user = User.new( params[:user] )
		@user.admin = admin
		if @user.save
			flash[:notice]= "User has been created."
			redirect_to admin_users_path
		else
			flash[:alert]= "User has not been created."
			render :action=>"new"
		end
	end
	def show
	end
	def edit
	end
	def update
		if params[:user][:password].blank?
			params[:user].delete(:password)
			params[:user].delete(:password_confirmation)
		end		
		admin = params[:user][:admin] == "1"
		params[:user].delete(:admin)
		@user.admin = admin
		if @user.update_attributes( params[:user] )
			flash[:notice] = "User has been updated."
			redirect_to admin_users_path
		else
			flash[:alert] = "User has not been updated."
			render :action=>"edit"
		end
	end
	def destroy
		if @user==current_user
			flash[:alert]= "You can not delete yourself!"
		else
			@user.destroy
			flash[:notice]= "User has been deleted."
		end
		redirect_to admin_users_path
	end	
private
	def set_admin
		@user.admin= params[:user][:admin]== "1"
	end
	def find_user
		@user= User.find(params[:id])
	end
end
