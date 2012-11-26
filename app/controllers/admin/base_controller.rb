class Admin::BaseController < ApplicationController
	before_filter :authorize_admin!
	
  def index
		@users= User.all(:order=>"email")
  end
end