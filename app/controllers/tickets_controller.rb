class TicketsController < ApplicationController
	before_filter :find_project
	before_filter :find_ticket,:only=> [:show,:edit,:update,:destroy]
	before_filter :authenticate_user!, :except => [:index, :show]
  #before_filter :authorize_update!, :only => [:edit, :update]
  #before_filter :authorize_delete!, :only => [:destroy]
	def	new
		@ticket = @project.tickets.build
	end
	def create
		@ticket = @project.tickets.build(params[:ticket].merge!(:user_id => current_user.id))
		if @ticket.save
			flash[:notice] = "Ticket has been created."
			redirect_to [@project,@ticket]
		else
			flash[:alert] = "Ticket has not been created."
			render:action => "new"
		end
	end
	def show
	end
	def edit
	end
	def update
		if @ticket.update_attributes(params[:ticket])
			flash[:notice] = "Ticket has been updated."
			redirect_to [@project,@ticket]
		else
			flash[:alert] = "Ticket has not been updated."
			render :action =>"edit"
		end
	end
	def	destroy
		@ticket.destroy
		flash[:notice]= "Ticket has been deleted."
		redirect_to @project
	end
private
	def find_project
		@project = Project.find(params[:project_id])
	end
	def find_ticket
		@ticket = @project.tickets.find(params[:id])
	end
	def authorize_create!
		if !current_user?
			flash[:alert] = "You cannot create tickets on this project."
			redirect_to @project
		end
	end

	def authorize_update!
		if !current_user.admin? && cannot?(:"edit tickets", @project)
			flash[:alert] = "You cannot edit tickets on this project."
			redirect_to @project
		end
	end

	def authorize_delete!
		if !current_user.admin? && cannot?(:"delete tickets", @project)
			flash[:alert] = "You cannot delete tickets from this project."
			redirect_to @project
		end
	end
end
