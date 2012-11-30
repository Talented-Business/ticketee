require 'spec_helper'

describe ProjectsController do
	login_user
	let(:project){ project = FactoryGirl.create(:project) }
	context "standard users" do
		it "cannot access the new action" do
			get :new
			response.should redirect_to(root_path)
			flash[:alert].should eql("You must be an admin to do that.")		
		end
	end
=begin
		{ "new"=>"get",	"create"=>"post",	"edit"=> "get",	"update"=>"put",
	"destroy"=>"delete"}.each do |action, method|
		it "cannot access the #{action} action" do
			send(method,action.dup,:id=>project.id)
			response.should redirect_to(root_path)
			flash[:alert].should eql("You must be an admin to do that.")
		end
	end 
=end
	it "cannot access the show action" do
		get :show, :id=>"not-here"
		response.should redirect_to(projects_path)
		flash[:alert].should eql("The project you were looking for could not be found.")
	end		
end
