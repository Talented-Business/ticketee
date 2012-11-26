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
	{ "new"=>"get",	"create"=>"post",	"edit"=> "get",	"update"=>"put",
	"destroy"=>"delete"}.each do |action, method|
		it "cannot access the #{action} action" do
			send(method,action.dup,:id=>project.id)
			response.should redirect_to(root_path)
			flash[:alert].should eql("You must be an admin to do that.")
		end
	end
end
