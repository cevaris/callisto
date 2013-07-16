class UserActivitiesController < ApplicationController

	def action
  	require_session
  	Rails.logger.info params

  	@user_activity = UserActivity.find params[:id]

  	case params[:request]
  	when :accept
  		state = ActivityState.find_by_name ActivityState::ACCEPTED
  	when :complete
  		state = ActivityState.find_by_name ActivityState::COMPLETED
  	when :decline
  		state = ActivityState.find_by_name ActivityState::FORFEITED
  	end

  	@user_activity.activity_state = state

		respond_to do |format|
			if @user_activity.save
				format.html { render :partial => 'action', :layout=>false }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end
  end

  
end
