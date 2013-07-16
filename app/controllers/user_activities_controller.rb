class UserActivitiesController < ApplicationController

	def show 
		Rails.logger.info params
		@activity = Activity.find params[:activity_id]
		@user_activity = UserActivity.find params[:id]

	end

	

  def complete
  	require_session
  	Rails.logger.info params
  	@activity = Activity.find params[:activity_id]
		@user_activity = UserActivity.find params[:user_activity_id]

  	action(:complete)

  	respond_to do |format|
			if @user_activity.save
				format.html { render :partial => 'action', :layout=>false }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end

  end

  def forfeit
  	require_session
  	Rails.logger.info params
  	@activity = Activity.find params[:activity_id]
		@user_activity = UserActivity.find params[:user_activity_id]

  	action(:forfeit)

  	respond_to do |format|
			if @user_activity.save
				format.html { render :partial => 'action', :layout=>false }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end
  	
  end




  def create
  	require_session

    @activity = Activity.find params[:activity_id]

    @user_activity = UserActivity.new
    @user_activity.activity = @activity
    @user_activity.activity_state = ActivityState.find_by_name ActivityState::ACCEPTED
    @user_activity.user = current_user

    respond_to do |format|
    	if @user_activity.save
    		format.html { redirect_to @user_activity, notice: 'Activity was successfully accepted.' }
    	else
  			format.html { redirect_to @activity, error: 'Activity could not be accepted.' }
    	end
    end
  end


  private 

  def action(request)

  	case request
	  	when :accept
	  		state = ActivityState.find_by_name ActivityState::ACCEPTED
	  	when :complete
	  		state = ActivityState.find_by_name ActivityState::COMPLETED
	  	when :forfeit
	  		state = ActivityState.find_by_name ActivityState::FORFEITED
	  	end

  	@user_activity.activity_state = state
  end


end
