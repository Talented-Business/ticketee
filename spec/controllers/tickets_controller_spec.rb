require 'spec_helper'

describe TicketsController do
	let(:user) { create_user! }
	let(:project){ project = FactoryGirl.create(:project)}
	let(:ticket){ ticket = FactoryGirl.create(:ticket,:project => project, :user => user) }
	context "standard users" do
		it "cannot access a ticket for a project" do
			sign_in( :user, user )
			get :show, :id=>ticket.id, :project_id => project.id
			response.should redirect_to(root_path)
			flash[:alert].should eql("The project you were looking for could not be found.")
		end
	end
	context "with permission to view the project" do
		before do
			sign_in(:user, user)
			Permission.create!(:user=>user, :thing => project,:action => "view")
		end
		def cannot_create_tickets!
			response.should redirect_to(project)
			flash[:alert].should eql("You cannot create tickets on this project.")
		end
		def cannot_update_tickets!
			response.should redirect_to(project)
			flash[:alert].should eql("You cannot edit tickets on this project.")
		end
		it "cannot begin to create a ticket" do
			get :new,:project_id => project.id
			cannot_create_tickets!
		end
		it "cannot create a ticket without permission" do
			post :create,:project_id => project.id
			cannot_create_tickets!
		end
		it "cannot edit a ticket without permission" do
			get :edit,{ :project_id=>project.id,:id => ticket.id }
			cannot_update_tickets!
		end
		it "cannot update a ticket without permission" do
			put :update,{ :project_id=>project.id,
										:id=>ticket.id,
										:ticket=>{}
									}
			cannot_update_tickets!
		end		
		it "cannot delete a ticket without permission" do
		delete :destroy,{ :project_id=> project.id, :id => ticket.id }
		response.should redirect_to(project)
		flash[:alert].should eql("You cannot delete tickets from this project.")
		end
	end	
end
