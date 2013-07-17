class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  # # This allows us to see the current controller and action for feedback
  # before_filter :instantiate_controller_and_action_names
  # caches_action :instantiate_controller_and_action_names

  # def instantiate_controller_and_action_names
  #   @current_action = action_name
  #   @current_controller = controller_name
  # end


  rescue_from ActiveRecord::RecordNotFound do
	  render 'static_pages/404', :status => 404
	end

end
